class Tag < ApplicationRecord
	##アソシエーション
    #has_many :posts, through: :post_tags
    #has_many :post_tags, dependent: :destroy
end