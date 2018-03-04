class TicketsController < ApplicationController
  before_action :authenticate_user!
  def index
    #test
    @status_headers = StatusHeader.all
    if current_user.project_ids.include? params[:project_id].to_i
      @project = Project.find_by_id(params[:project_id])
      @tickets = @project.tickets.where("maker = ? OR receipt = ?", current_user.id, current_user.id)
      @users = User.all
    else
      flash[:error] = "You not have an access!"
      redirect_to root_path
    end
  end

  def new
    @ticket = Ticket.new
  end

  def create
    user_id = User.find_by_id(params[:ticket][:user_id]).id
  	@ticket = Ticket.new(params_ticket)
    @ticket.project_id = params[:project_id]
    @ticket.status = "Backlog"
    @ticket.maker = current_user.id
    @ticket.receipt = user_id
  	if @ticket.save
      UserTicket.create(user_id: current_user.id, ticket_id: @ticket.id, is_maker: true)
      UserTicket.create(user_id: params[:ticket][:user_id], ticket_id: @ticket.id, is_maker: false)
      # ActionCable.server.broadcast 'ticket_channel', 
      #   view: ApplicationController.render(
      #     partial: '/tickets/tickets_list',
      #     locals: { ticket: @ticket }
      #     ),
      #   project_id: params[:project_id],
      #   user_id_1: current_user.id,
      #   user_id_2: params[:ticket][:user_id]
    end
  end

  def update
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(params_ticket)
  end

  def change_status_ticket
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(status: params[:status_ticket])
    ActionCable.server.broadcast 'change_ticket_channel', ticket_id: @ticket.id
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
  	params.require(:ticket).permit(:code, :title, :description, :status, :project_id, :category, :priority)
  end
end
