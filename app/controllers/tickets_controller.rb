class TicketsController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.project_ids.include? params[:project_id].to_i
      @project = Project.find_by_id(params[:project_id])
      @tickets = @project.tickets
      @users = User.all
    else
      flash[:error] = "You not have an access!"
      redirect_to root_path
    end
  end

  def new
  end

  def create
  	@ticket = Ticket.new(params_ticket)
    @ticket.project_id = params[:project_id]
    @ticket.status = "New"
  	if @ticket.save
      UserTicket.create(user_id: current_user.id, ticket_id: @ticket.id, is_maker: true)
      UserTicket.create(user_id: params[:ticket][:users], ticket_id: @ticket.id, is_maker: false)
      ActionCable.server.broadcast 'ticket_channel', 
        view: ApplicationController.render(
          partial: '/dashboard/tickets_list',
          locals: { ticket: @ticket }
          ),
        project_id: params[:project_id]
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
  	params.require(:ticket).permit(:code, :title, :description, :status, :project_id)
  end
end
