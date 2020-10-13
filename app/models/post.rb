class Post < ApplicationRecord
    #アソシエーション
	belongs_to :user
	attachment :image
	#バリデーション
	validates :image, presence: true
	validates :content, presence: true
	validates :tag_content, presence: true
end