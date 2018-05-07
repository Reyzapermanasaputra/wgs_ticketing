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
    @project = Project.find_by_id(params[:project_id])
    @headers = @project.headers
    @users = User.all
    @ticket.header_id = @headers.first.id
    @ticket.maker_id = current_user.id
    @ticket.start_date = params[:ticket][:start_date].to_date
    @ticket.start_date = params[:ticket][:end_date].to_date
    if @ticket.save
      flash[:notice] = "Ticket was created!"
      #broadcast ticket
      ActionCable.server.broadcast 'ticket_channel', 
      view: ApplicationController.render(
        partial: '/tickets/index/index',
        locals: {:project => @project, :headers => @headers, :users => @users }
        ),
      project_id: params[:project_id]

      #broadcast notification
      action = "was created a new ticket for You with id #" + @ticket.id.to_s
      project_path = "projects/#{params[:project_id]}/tickets"
      notification = Notification.create(recipient: @ticket.recipient, actor: current_user, action: action, notifiable: @ticket, path: project_path)
      user = User.find_by_id(notification.recipient_id)
      ActionCable.server.broadcast 'notification_channel',
                                    action: action,
                                    recipient: user.id,
                                    notification_id: user.notifications.last.id,
                                    last_notification_id: user.notifications.last(2).first.id,
                                    notification_time: notification.created_at.strftime("%d-%m-%y %H:%M"),
                                    notification_actor: notification.actor.username,
                                    audio_id: "create_ticket_"

      #send mailer
      Mailer.send_ticket(@ticket.recipient, @ticket.maker, @ticket).deliver if params[:ticket][:priority].eql? "High"
      redirect_to action: "index"   
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
    @project = Project.find_by_id(params[:project_id])
    @headers = @project.headers
    @users = User.all
    header.destroy
    ActionCable.server.broadcast 'ticket_channel', 
      view: ApplicationController.render(
        partial: '/tickets/index/index',
        locals: {:project => @project, :headers => @headers, :users => @users }
        ),
      project_id: params[:project_id]
  end

  def edit
    @project = Project.find_by_id(params[:project_id])
    @users = @project.users.where.not(role_id: current_user.role_id)
    @ticket = Ticket.find_by_id(params[:id])
  end

  def update
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes(params_ticket)
    Mailer.send_ticket(@ticket.recipient, @ticket.maker, @ticket).deliver if params[:ticket][:priority].eql? "High"
    if @ticket.errors.present?
      @project = Project.find_by_id(params[:project_id])
      @users = @project.users
      flash[:notice] = @ticket.errors.full_messages.map{|k,v| k}.join("<br/>").html_safe
      render 'edit'
    else
      flash[:notice] = "Ticket was edited!"
      Mailer.send_ticket(@ticket.recipient, @ticket.maker, @ticket).deliver if params[:ticket][:priority].eql? "High"
      redirect_to action: "index"   
    end
  end

  def change_status_ticket
    @ticket = Ticket.find_by_id(params[:id])
    @ticket.update_attributes!(header_id: params[:header_id])
    #broadcast ticket
    @project = Project.find_by_id(params[:project_id])
    @headers = @project.headers
    @users = User.all
      ActionCable.server.broadcast 'ticket_channel', 
      view: ApplicationController.render(
        partial: '/tickets/index/index',
        locals: {:project => @project, :headers => @headers, :users => @users }
        ),
      project_id: params[:project_id]

      #broadcast notification
      action = "was changed the ticket #" + @ticket.id.to_s + " to #{@ticket.header.status}"
      project_path = "projects/#{params[:project_id]}/tickets"
      notification = Notification.create(recipient: @ticket.recipient, actor: current_user, action: action, notifiable: @ticket, path: project_path)
      user = User.find_by_id(notification.recipient_id)
      ActionCable.server.broadcast 'notification_channel',
                                    action: action,
                                    recipient: user.id,
                                    notification_id: user.notifications.last.id,
                                    last_notification_id: user.notifications.last(2).first.id,
                                    notification_time: notification.created_at.strftime("%d-%m-%y %H:%M"),
                                    notification_actor: notification.actor.username,
                                    audio_id: "change_ticket_"
  end

  def archive
    @ticket = Ticket.find_by_id(params[:ticket_id])
    if @ticket.is_archive.nil?
      @ticket.update_attributes(is_archive: true)
    else
      @ticket.update_attributes(is_archive: nil)
    end
    redirect_to action: "index"
  end

  def list_archive
    @tickets = Ticket.where(is_archive: true)
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
    #broadcast ticket
    @project = Project.find_by_id(params[:project_id])
    @headers = @project.headers
    @users = User.all
    
      ActionCable.server.broadcast 'ticket_channel', 
      view: ApplicationController.render(
        partial: '/tickets/index/index',
        locals: {:project => @project, :headers => @headers, :users => @users }
        ),
      project_id: params[:project_id]

      #broadcast notification
      action = "was changed the ticket #" + @ticket.id.to_s + " to #{@ticket.header.status}"
      project_path = "projects/#{params[:project_id]}/tickets"
      notification = Notification.create(recipient: @ticket.recipient, actor: current_user, action: action, notifiable: @ticket, path: project_path)
      user = User.find_by_id(notification.recipient_id)
      ActionCable.server.broadcast 'notification_channel',
                                    action: action,
                                    recipient: user.id,
                                    notification_id: user.notifications.last.id,
                                    last_notification_id: user.notifications.last(2).first.id,
                                    notification_time: notification.created_at.strftime("%d-%m-%y %H:%M"),
                                    notification_actor: notification.actor.username,
                                    audio_id: "comment_ticket_"
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
