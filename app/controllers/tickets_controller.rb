class TicketsController < ApplicationController
  before_action :authenticate_user!
  def index
    @project = Project.find_by_id(params[:project_id])
    @headers = @project.headers
    @users = User.all
  end

  def new
    @project = Project.find_by_id(params[:project_id])
    @users = @project.users
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params_ticket)
    header = Project.find_by_id(params[:project_id]).headers.first
    @ticket.header_id = header.id
    @ticket.status = "New"
    @ticket.maker_id = current_user.id
    @ticket.start_date = params[:ticket][:start_date].to_date
    @ticket.start_date = params[:ticket][:end_date].to_date
    if @ticket.save
      redirect_to action: "index"
    else
      render 'new'
    end
   #  user_id = User.find_by_id(params[:ticket][:user_id]).id
  	# @ticket = Ticket.new(params_ticket)
   #  @ticket.project_id = params[:project_id]
   #  @ticket.status = "Backlog"
   #  @ticket.maker = current_user.id
   #  @ticket.receipt = user_id
  	# if @ticket.save
   #    UserTicket.create(user_id: current_user.id, ticket_id: @ticket.id, is_maker: true)
   #    UserTicket.create(user_id: params[:ticket][:user_id], ticket_id: @ticket.id, is_maker: false)
      # ActionCable.server.broadcast 'ticket_channel', 
      #   view: ApplicationController.render(
      #     partial: '/tickets/tickets_list',
      #     locals: { ticket: @ticket }
      #     ),
      #   project_id: params[:project_id],
      #   user_id_1: current_user.id,
      #   user_id_2: params[:ticket][:user_id]
    #end
  end

  def create_header
    header = Header.new(params_header)
    @project = Project.find_by_id(params[:header][:project_id])
    @headers = @project.headers
    @users = User.all
    header.save
  end

  def remove_header
    header = Header.find_by_id(params[:header_id])
    header.destroy
  end

  def update
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(params_ticket)
  end

  def change_status_ticket
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(status: params[:status_ticket], header_id: params[:header_id])
    #ActionCable.server.broadcast 'change_ticket_channel', ticket_id: @ticket.id
  end

  def show
    @ticket = Ticket.find_by_id(params[:id])
    @project = Project.find_by_id(params[:project_id])
  end

  def destroy
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.destroy
    ActionCable.server.broadcast 'remove_ticket_channel', id: @ticket.id
  end
  
  private

  def params_ticket
  	params.require(:ticket).permit(:code, :title, :description, :status, :category, :priority, :recipient_id, :maker_id, :header_id, :start_date, :end_date)
  end

  def params_header
    params.require(:header).permit(:status, :color, :project_id)
  end
end
