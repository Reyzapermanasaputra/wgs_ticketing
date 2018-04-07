class DashboardController < ApplicationController
	before_action :authenticate_user!
  
  def index
  	@roles_id = Role.where(name: "Project Manager")
    @projects = Project.active
  end
end
