class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  #Overwrite the sign out redirect path
  def after_sign_out_path_for(resource_or_scope)
  	user_session_path
  end

  def authenticate_user_registration
    redirect_to new_user_session_url unless user_signed_in?
  end

  # def current_ability
  #   # I am sure there is a slicker way to capture the controller namespace
  #   controller_name_segments = params[:controller].split('/')
  #   controller_name_segments.pop
  #   controller_namespace = controller_name_segments.join('/').camelize
  #   AbilityCont.new(current_user, controller_namespace)
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role_id, :is_active, :contact, :address])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username, :role_id, :is_active, :contact, :address])
    devise_parameter_sanitizer.permit(:invite, keys: [:username, :role_id, :is_active, :contact, :address])
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

end
