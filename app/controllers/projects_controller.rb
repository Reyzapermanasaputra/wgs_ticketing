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

  def edit
  end

  private
  def params_projects
  	params.require(:project).permit(:name, :description, clients_attributes: [:id, :name, :contact, :address, :_destroy])
  end
end
