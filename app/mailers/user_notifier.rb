class UserNotifier < ApplicationMailer
  default :from => 'noreply@teamboardapp.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(inviter, invited)
    @inviter = inviter
    mail( :to => invited.email,
    :subject => 'TeamBoard Invitation' )
  end
end
