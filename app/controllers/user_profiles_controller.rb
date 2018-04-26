class UserProfilesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource :class => User
  def index
  	@users = User.where("role_id is not null")
  end

  def edit
  	@user_profile = User.find_by_id(params[:id])
  end

  def update
  	@user_profile = User.find_by_id(params[:id])
  	@user_profile.update_attributes(params_user_profile)
  	redirect_to action: "index"
  end

  def destroy
  	@user = User.find_by_id(params[:id])
  	@user.destroy
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
