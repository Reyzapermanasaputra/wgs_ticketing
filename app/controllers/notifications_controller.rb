class NotificationsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_notfications

	def set_notifications
		@notifications = Notification.where(recipient: current_user).unread
	end
end
