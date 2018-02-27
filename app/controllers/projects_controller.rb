class ProjectsController < ApplicationController
  
  def index
  	@projects = Project.all
  end

  def new
  	@project = Project.new
  	@project.clients.build
  end

  def create
  	@project = Project.new(params_projects)
  	if @project.save
  		flash[:notice] = "The Project was Added!"
  		redirect_to action: "index"
  	else
  		flash[:error] = "There is error occured!"
  		render 'new'
  	end
  end

  def show
    @project = Project.find_by_id(params[:id])
    user_ids = @project.users.collect(&:id)
    user_ids = 0 if user_ids.blank?
    @users = User.where(["id not in (?)",user_ids])
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
  end

  def destroy
    project = Project.find_by_id(params[:id])
    project.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def params_projects
  	params.require(:project).permit(:name, :description, clients_attributes: [:id, :name, :contact, :address, :_destroy])
  end
end
