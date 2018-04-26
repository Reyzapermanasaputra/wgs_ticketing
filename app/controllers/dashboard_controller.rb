class DashboardController < ApplicationController
	before_action :authenticate_user!
  authorize_resource :class => false
  
  def index
  	@roles_id = Role.where(name: "Project Manager")
    @projects = Project.active
    
    @chart = {}
    @ticket = []
    Project.all.active.each do |project|
    	project.headers.all.each_with_index do |header, index|
    		if header.tickets.present?
    		  @chart.merge!({:"#{project.name}" => header.tickets.count})
    	  end
    	end
    end
  end
end
