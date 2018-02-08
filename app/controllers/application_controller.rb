class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private

  #Overwrite the sign out redirect path
  def after_sign_out_path_for(resource_or_scope)
  	user_session_path
  end

end
