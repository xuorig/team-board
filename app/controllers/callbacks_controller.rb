class CallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_method
  end

  def facebook
    callback_method
  end

  def callback_method
    @invite_token = request.env["omniauth.params"]["token"]
    if @invite_token
      byebug
      verify_token @invite_token
    end

    @user = User.from_omniauth(request.env["omniauth.auth"])
    
    if @invite_token
      @user.accept_invite @invite_token
    end
    sign_in_and_redirect @user
  end

end