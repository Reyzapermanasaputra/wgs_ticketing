class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource :class => User
  def index
  	@users = User.filter(params).page(params[:page]).per(5)
    authorize! :read, @users
  end

  def edit
  	@user_profile = User.find_by_id(params[:id])
  end

  def update
  	@user_profile = User.find_by_id(params[:id])
  	@user_profile.update_attributes(params_user_profile)
    if @user_profile.errors.present?
      flash[:error] = @user_profile.errors.full_messages.map { |k,v| k }.join('<br>').html_safe
      render action: 'edit'
    else
      flash[:notice] = "User was updated"
      if current_user.role.code.eql?("PM")
        redirect_to action: "index"
      else
        redirect_to action: "show"
      end
    end
  end

  def destroy
  	@user = User.find_by_id(params[:id])
  	@user.destroy
    flash[:notice] = "User was destroyed"
    redirect_to action: "index"
  end

  def send_invitation_again
    user = User.find_by_id(params[:id])
    user.invite!(current_user)
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  private
  def params_user_profile
  	params.require(:user).permit(:username, :role_id, :is_active, :contact, :email, :address)
  end
end
