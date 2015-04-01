class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!
  layout :layout_by_resource

  def invite_user as_manager
    @invitation = Invitation.where({:email => safe_params[:email]}).first_or_create do |invitation|
      invitation.email = safe_params[:email]
      invitation.save!
    end
    InvitationTeam.create!(:as_manager => as_manager, :team_id => safe_params[:team_id], 
                              :invitation_id => @invitation.id)
    UserNotifier.send_signup_email(current_user, @invitation, safe_params[:email]).deliver_now
    return @invitation
  end

  def verify_token invite_token
    if Invitation.where({:token => invite_token}).blank?
      raise "Invalid Token"
    else
      if Invitation.where({:token => invite_token}).first.accepted
        raise "Already Claimed Token"
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def layout_by_resource
    if user_signed_in?
      'application'
    else
      'splash'
    end
  end
end
