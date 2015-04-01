class CallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      callback_method
    end

    def facebook
      callback_method
    end

    def callback_method
      @user = User.from_omniauth(request.env["omniauth.auth"])
      @invite_token = request.env["omniauth.params"]["token"]
      if @invite_token
        @invitation = Invitation.where({:token => @invite_token}).first
        @invitation.teams.each do |team|
          team.users << @user
        end
        @invitation.accepted = true
        @invitation.save!
      end
      sign_in_and_redirect @user
    end

end