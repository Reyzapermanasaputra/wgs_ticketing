class DashboardController < ApplicationController
	before_action :authenticate_user!
  
  def index
  	@tickets = Ticket.all
  end
end
