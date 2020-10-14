class Relationship < ApplicationRecord
	#アソシエーション
	#フォローするユーザー
	belongs_to :follower, class_name: 'User'
	#フォローされるユーザー
	belongs_to :followed, class_name: 'User'
end