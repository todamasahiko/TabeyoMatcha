class Notification < ApplicationRecord
	###アソシエーション
	##通知機能
    #通知を新着順にする
    default_scope -> { order(created_at: :desc) }
    belongs_to :post, optional: true #idにnilを許可する
    belongs_to :comment, optional: true #idにnilを許可する
    #belongs_to :room, optional: true #idにnilを許可する
    #belongs_to :message, optional: true #idにnilを許可する
    #自分からの通知
    belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
    #相手からの通知
    belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end