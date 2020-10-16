class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	##アソシエーション
	devise :database_authenticatable, :registerable,
		     :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  attachment :profile_image
  has_many :comments, dependent: :destroy
  has_many :likes
  #has_many :like_posts, through: :likes
  #has_many :bookmarks, dependent: :destroy
  ##フォロー・フォロワー機能
  #フォローをする
  #has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  #フォローをされている
  #has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  #自分がフォローをしているユーザー
  #has_many :following_user, through: :follower, source: :followed
  #自分がフォローをされているユーザー
  #has_many :follower_user, through: :followed, source: :follower
  #ユーザーをフォローする
  #def follow(user_id)
    #follower.create(followed_id: user_id)
  #end
  #ユーザーのフォローを外す
  #def unfollow(user_id)
    #follower.find_by(followed_id: user_id).destroy
  #end
  #フォロー有無の確認
  #def following?(user)
    #following_user.include?(user)
  #end
  ##バリデーション
  #ニックネーム(15字以内)
  validates :nickname, presence: true, length: { maximum: 15 }
	#メールアドレス
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
	#パスワード(半角英数字、8文字以上)
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, presence: true, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX }
end