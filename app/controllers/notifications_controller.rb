class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@notifications = current_user.notifications.order("created_at DESC").page(params[:page]).per(5)
	end

	def update_unread
		current_user.notifications.unread.update_all(read_at: Time.now)
	end
end
