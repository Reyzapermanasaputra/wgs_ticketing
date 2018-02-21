class TicketsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tickets = Ticket.all
  end

  def new
  end

  def create
  	@ticket = Ticket.new(params_ticket)
    @ticket.status = "New"
  	if @ticket.save
      ActionCable.server.broadcast 'ticket_channel', 
        view: ApplicationController.render(
          partial: '/dashboard/tickets_list',
          locals: { ticket: @ticket }
          )
    end
  end

  def update
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(params_ticket)
  end

  def change_status_ticket
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(status: params[:status_ticket])
  end

  def show
    @ticket = Ticket.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.destroy
    ActionCable.server.broadcast 'remove_ticket_channel', id: @ticket.id
  end
  
  private

  def params_ticket
  	params.require(:ticket).permit(:code, :title, :description, :status)
  end
end
