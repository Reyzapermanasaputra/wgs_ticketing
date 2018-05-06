class TicketsController < ApplicationController
  before_action :authenticate_user!
  def index
    @project = Project.find_by_id(params[:project_id])
    @headers = @project.headers
    @users = User.all
  end

  def new
    @project = Project.find_by_id(params[:project_id])
    @users = @project.users.where.not(role_id: current_user.role_id)
    @ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(params_ticket)
    header = Project.find_by_id(params[:project_id]).headers.first
    @ticket.header_id = header.id
    @ticket.maker_id = current_user.id
    @ticket.start_date = params[:ticket][:start_date].to_date
    @ticket.start_date = params[:ticket][:end_date].to_date
    if @ticket.save
      flash[:notice] = "Ticket was created!"
      redirect_to action: "index"
      #need refactor
      # ActionCable.server.broadcast 'ticket_channel', 
      #   view: ApplicationController.render(
      #     partial: '/tickets/tickets_list',
      #     locals: { ticket: @ticket }
      #     ),
      #   project_id: params[:project_id],
      #   user_id_1: current_user.id,
      #   user_id_2: params[:ticket][:user_id]      
    else
      @project = Project.find_by_id(params[:project_id])
      @users = @project.users
      flash[:notice] = @ticket.errors.full_messages.map{|k,v| k}.join("<br/>").html_safe
      render 'new'
    end
  end

  def create_header
    header = Header.new(params_header)
    @project = Project.find_by_id(params[:header][:project_id])
    @headers = @project.headers
    @users = User.all
    header.save
    ActionCable.server.broadcast 'ticket_channel', 
      view: ApplicationController.render(
        partial: '/tickets/index/index',
        locals: {:project => @project, :headers => @headers, :users => @users }
        ),
      project_id: params[:project_id]
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
    @ticket.update_attributes!(header_id: params[:header_id])
    #ActionCable.server.broadcast 'change_ticket_channel', ticket_id: @ticket.id
  end

  def show
    @ticket = Ticket.find_by_id(params[:id])
    @project = Project.find_by_id(params[:project_id])
    @comments = @ticket.comments
  end

  def destroy
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.destroy
    ActionCable.server.broadcast 'remove_ticket_channel', id: @ticket.id
  end

  def comment
    comment = Comment.new(params_comment)
    comment.save
    ticket = Ticket.find_by_id(params[:comment][:ticket_id])
    @comments = ticket.comments
  end

  def delete_comment
    comment = Comment.find_by_id(params[:id])
    @comment_id = comment.id
    comment.destroy
  end
  
  private

  def params_ticket
  	params.require(:ticket).permit(:title, :description, :category, :priority, :recipient_id, :maker_id, :header_id, :start_date, :end_date)
  end

  def params_header
    params.require(:header).permit(:status, :color, :project_id)
  end

   def params_comment
    params.require(:comment).permit(:ticket_id, :user_id, :body)
  end
end
