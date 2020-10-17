class RelationshipsController < ApplicationController
	#アクセス制限
	before_action :authenticate_user!
    #ユーザーをフォローする
	def create
		current_user.follow(params[:user_id])
		@user.create_notification_follow(current_user) #フォロー通知
		redirect_to request.referer
	end
    #ユーザーのフォローを外す
	def destroy
		current_user.unfollow(params[:user_id])
		redirect_to request.referer
	end
	#フォロー一覧
	def follower
		user = User.find(params[:user_id])
		@users = user.following_user
	end
	#フォロワー一覧
	def followed
		user = User.find(params[:user_id])
		@users = user.follower_user
	end
end