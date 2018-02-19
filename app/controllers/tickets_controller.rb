class TicketsController < ApplicationController
  def index
  end

  def new
  end

  def create
  	@ticket = Ticket.new(params_ticket)
    @ticket.status = "New"
  	@ticket.save
  end

  def edit
  end

  def change_status_ticket
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(status: params[:status_ticket])
  end

  def destroy
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.destroy
  end
  
  private

  def params_ticket
  	params.require(:ticket).permit(:code, :title, :description, :status)
  end
end
