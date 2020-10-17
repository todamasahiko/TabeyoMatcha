module NotificationsHelper
	#未確認通知を検索する
	def unchecked_notifications
		@notifications = current_user.passive_notifications.where(checked: false)
	end
end