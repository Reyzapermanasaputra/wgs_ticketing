class Users::InvitationsController < Devise::InvitationsController
	load_and_authorize_resource
  def update
	  if User.accept_invitation!(user_params)
	    super
	    redirect_to user_profiles_path, notice: t('invitaion.accepted')
	  else
	    redirect_to user_profiles_path, error: t('invitation.not_accepted')
	  end
	end

end