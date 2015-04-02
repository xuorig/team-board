class UserNotifier < ApplicationMailer
  default :from => 'noreply@teamboardapp.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(inviter, invitation, email)
    @inviter = inviter
    @invitation = invitation
    mail( :to => email,
    :subject => 'TeamBoard Invitation' )
  end
end
