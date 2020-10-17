class NotificationsController < ApplicationController

	def index
		#ログインユーザーの投稿に紐付いた通知一覧
		@notifications = current_user.passive_notifications
		#@notificationからまだ未確認の通知を取り出す、確認済に更新する
		@notifications.where(checked: false).each do |notification|
			notification.update_attributes(checked: true)
		end
	end
	#通知をすべて削除する
	def destroy_all
		@notifications = current_user.passive_notifications.destroy_all
		redirect_to notifications_path
	end
end