class User < ApplicationRecord
    # Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	#アソシエーション
	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable
    has_many :posts, dependent: :destroy
    #バリデーション
    #ニックネーム(15字以内)
  	validates :nickname, presence: true, length: { maximum: 15 }
	#メールアドレス
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
	#パスワード(半角英数字、8文字以上)
  	VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  	validates :password, presence: true, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX }
end