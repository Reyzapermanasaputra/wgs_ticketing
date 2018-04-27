class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
  	@projects = Project.all.order("created_at asc")
  end

  def new
  	@project = Project.new
  	@project.clients.build
  end

  def create
  	@project = Project.new(create_params)
  	if @project.save
  		flash[:notice] = "The Project was Added!"
  		redirect_to action: "index"
  	else
  		flash[:error] = @project.errors.full_messages.map { |k,v| k }.join('<br>').html_safe
  		render 'new'
  	end
  end

  def show
    roles_id = Role.where(name: "Project Manager")
    user_ids = UserProject.pluck(:user_id)
    @project = Project.find_by_id(params[:id])
    user_project_ids = UserProject.where(project_id: @project, user_id: user_ids).pluck(:user_id)
    project_ids = UserProject.pluck(:project_id)
    @users_list = JSON.parse(User.active.where.not(id: user_project_ids, role_id: roles_id).to_json)
    @project_user = JSON.parse(@project.users.active.where.not(role_id: roles_id).to_json)
    #get credential need refactor
    if @project.credential.nil?
      @credential = @project.build_credential
      @check_credential = true
    else
      @credential = @project.credential
      @check_credential = false
    end
    #get document need refactor
    if @project.documents.blank?
      @message = "there is no document's project"
    else
      @document = @project.documents
      @message = false
    end
  end

  def update
    project = Project.find_by_id(params[:id])
    project.update_attributes(create_params)
    if project.errors.present?
      flash[:notice] = project.errors.full_messages.map { |k,v| k }.join('<br>').html_safe
      render "new"
    else
      flash[:notice] = "Project was updated"
      redirect_to action: "index"
    end
  end

  def assigning_users
    params[:users].each do |user|
      UserProject.create(user_id: user, project_id: params[:project_id])
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy_assign_user
    user_project = UserProject.find_by_user_id_and_project_id(params[:user_id], params[:project_id])
    user_project.destroy
    redirect_back(fallback_location: root_path)
  end

  def edit
    @project = Project.find_by_id(params[:id])
  end

  def destroy
    project = Project.find_by_id(params[:id])
    project.destroy
    flash[:notice] = "Project was deleted"
    redirect_to projects_path
  end

  private
  def create_params
  	params.require(:project).permit(:name, :description, :is_active, clients_attributes: [:id, :name, :contact, :address, :latitude, :longitude, :_destroy])
  end
end
