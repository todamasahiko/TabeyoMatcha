class Post < ApplicationRecord
    ###アソシエーション
	belongs_to :user
	attachment :image
	##コメント機能
	has_many :comments
	##いいね機能
	has_many :likes
	#ユーザーが「いいね」をしているか確認
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end
	##ランキング機能
	def self.all_ranks
		Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
	end
	##通知機能
	has_many :notifications
	#いいね通知
	def create_notification_like(curret_user)
		#すでに「いいね」済みか確認、「いいね」した際に1度だけ通知が行く
		temp = Notification.where(['visiter_id = ? and visited_id = ? and post_id = ? and action = ?', curret_user.id, user_id, id, 'like'])
		#まだ「いいね」されていない場合、通知レコードを作る
		if temp.blank?
			notification = curret_user.active_notifications.new(post_id: id, visited_id: user_id, action: 'like')
			#自分の投稿への「いいね」は事前に通知済にしておく
			if notification.visiter_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end
	#コメント通知
	def create_notification_comment(curret_user, comment_id)
		#自分以外のコメントをしたすべてのユーザーを取得、その全員に通知を送る
		#投稿にコメントしているユーザーIDの取得、自分のコメントを除外、重複時は削除する
		temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: curret_user.id).distinct #distinct=重複を1つにまとめる
		temp_ids.each do |temp_id|
			save_notification_comment(curret_user, comment_id, temp_id['user_id'])
		end
		#まだ誰からも「コメント」がない場合、投稿者に通知を送る
		save_notification_comment(curret_user, comment_id, user_id) if temp_ids.blank?
	end

	def save_notification_comment(curret_user, comment_id, visited_id)
		#コメントを複数回行われることが考えられるため、1つの投稿への複数回通知をする
		notification = curret_user.active_notifications.new(post_id: id, comment_id: comment_id, visited_id: visited_id, action: 'comment')
		#自分の投稿への「コメント」は事前に通知済にしておく
		if notification.visiter_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end
	##PV機能
	is_impressionable counter_cache: true
	##タグ機能
	#has_many :tags, through: :post_tags
	#has_many :post_tags, dependent: :destroy
	#新規投稿時
	#after_create do
		#作成した投稿を探す
		#post = Post.find_by(id: id)
		#tag_contentに入力されたタグを取得する
		#tags = tag_content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
		#map文によって、複数のタグをpostに保存させる
		#tags.uniq.map do |tag|
			#Tagがすでに存在しているかを確認、なければ新規作成する
			#大文字から小文字へ変換、タグは先頭の「#」を外した状態で保存する
			#tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
			#1つの投稿に対して、複数のタグを一度で保存する
			#post.tags << tag
		#end
	#end
	#更新時
	#before_update do
		#post = Post.find_by(id: id)
		#一度タグを削除する
		#post.tags.clear
		#tags = tag_content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
		#tags.uniq.map do |tag|
			#tag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
			#post.tags << tag
		#end
	#end
	##ブックマーク機能
	#has_many :bookmarks, dependent: :destroy
	#def bookmarked_by?(user)
		#bookmarks.where(user_id: user.id).exists?
	#end
	###バリデーション
	validates :image, presence: true
	validates :content, presence: true
	validates :tag_content, presence: true
end