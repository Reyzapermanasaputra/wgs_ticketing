class RegistrationsController < Devise::RegistrationsController
	before_action :authenticate_user_registration
	prepend_before_action :require_no_authentication, only: [:cancel]
  
  def new
  	super
  end

  def edit
  	@user = User.find_by_id(params[:id])
  end
end