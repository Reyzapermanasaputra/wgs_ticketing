class AssignProjectsController < ApplicationController
	before_action :authenticate_user!
  def index
  	@projects = Project.all
  end

  def create
    if params[:assign_project][:project_id] == "_user"
      user_project = UserProject.where(user_id: params[:assign_project][:user_id], project_id: params[:source])
    else
      user_project = UserProject.where(user_id: params[:assign_project][:user_id], project_id: params[:assign_project][:project_id])
    end

  	if user_project.blank?
      assign_project = UserProject.new(params_assign_project)
      assign_project.save
      action = UserProject.create_action(params[:assign_project][:project_id], "assigned You to ")
      project_path = "projects/#{params[:assign_project][:project_id]}"
      notification = Notification.create(recipient: assign_project.user, actor: current_user, action: action, notifiable: assign_project, path: project_path)
      user = User.find_by_id(assign_project.user.id)
      ActionCable.server.broadcast 'notification_channel',
                                    action: action,
                                    recipient: assign_project.user.id,
                                    notification_id: user.notifications.last.id,
                                    last_notification_id: user.notifications.last(2).first.id,
                                    notification_time: notification.created_at.strftime("%d-%m-%y %H:%M"),
                                    notification_actor: notification.actor.username,
                                    audio_id: 'assign_user_'
  	else
      assign_project = UserProject.where(user_id: params[:assign_project][:user_id], project_id: params[:source]).last
      assign_project.destroy
      action = UserProject.create_action(params[:source], "removed You from ")
      notification = Notification.create(recipient: assign_project.user, actor: current_user, action: action, notifiable: assign_project)
      user = User.find_by_id(assign_project.user.id)
      ActionCable.server.broadcast 'notification_channel',
                                    action: action,
                                    recipient: assign_project.user.id,
                                    notification_id: user.notifications.last.id,
                                    last_notification_id: user.notifications.last(2).first.id,
                                    notification_time: notification.created_at.strftime("%d-%m-%y %H:%M"),
                                    notification_actor: notification.actor.username,
                                    audio_id: 'assign_user_'
	  end
  end
  
  private

  def params_assign_project
  	params.require(:assign_project).permit(:user_id, :project_id)
  end
end
