class DashboardController < ApplicationController
	before_action :authenticate_user!
  authorize_resource :class => false
  
  def index
  	@roles_id = Role.where(name: "Project Manager")
    @projects = Project.active
    
    @chart = {}
    @tickets_count = []
    Project.all.active.each do |project|
    	project.headers.all.each_with_index do |header, index|
    		if header.tickets.where(is_archive: nil).present?
          @tickets_count << header.tickets.count
    	  end
        @chart.merge!({:"#{project.name}" => @tickets_count.sum})
    	end
    end
  end

  def users_reports
    role = Role.find_by_code("PM")
    @users = User.where.not(role_id: nil, role_id: role.id)
  end
end
