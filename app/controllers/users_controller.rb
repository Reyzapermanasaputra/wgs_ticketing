class Users::InvitationsController < Devise::InvitationsController
  def update
	  if User.accept_invitation!(user_params)
	    super
	    redirect_to dashboard_show_path, notice: t('invitaion.accepted')
	  else
	    redirect_to root_path, error: t('invitation.not_accepted')
	  end
	end

end