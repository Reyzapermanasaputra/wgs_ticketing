class HeadersController < ApplicationController
	before_action :authenticate_user!
	
	def create
		header = Header.new(params_header)
    header.save
    @project = Project.find_by_id(params[:header][:project_id])
    @headers = @project.headers
    @users = User.all
	end

  private
	def params_header
  	params.require(:header).permit(:status, :color, :project_id)
  end
end
