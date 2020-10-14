class Post < ApplicationRecord
    #アソシエーション
	belongs_to :user
	attachment :image
	has_many :comments, dependent: :destroy
	#いいね機能
	has_many :likes, dependent: :destroy
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end
	#ブックマーク機能
	has_many :bookmarks, dependent: :destroy
	def bookmarked_by?(user)
		bookmarks.where(user_id: user.id).exists?
	end
	#バリデーション
	validates :image, presence: true
	validates :content, presence: true
	validates :tag_content, presence: true
end