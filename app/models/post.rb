class Post < ApplicationRecord
    ##アソシエーション
	belongs_to :user
	attachment :image
	has_many :comments, dependent: :destroy
	##いいね機能
	has_many :likes
	#ユーザーがいいねをしているか確認
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end
	##ランキング機能
	def self.all_ranks
		Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
	end
	##ブックマーク機能
	#has_many :bookmarks, dependent: :destroy
	#def bookmarked_by?(user)
		#bookmarks.where(user_id: user.id).exists?
	#end
	##バリデーション
	validates :image, presence: true
	validates :content, presence: true
	validates :tag_content, presence: true
end