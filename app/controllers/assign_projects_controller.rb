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
  	else
      assign_project = UserProject.where(user_id: params[:assign_project][:user_id], project_id: params[:source]).last
      assign_project.destroy
	  end
  end
  
  def params_assign_project
  	params.require(:assign_project).permit(:user_id, :project_id)
  end
end
