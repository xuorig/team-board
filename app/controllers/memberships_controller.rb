class MembershipsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @membership = Membership.where({team_id: params[:team_id], user_id: params[:user_id]})
    if @membership
      render json: @membership, status:200
    end
  end

  def show
  end

  # POST /teams
  def create
    user = User.where(email: safe_params[:email])
    if not user.blank?
      @user = user.first
      @membership = Membership.new({:team_id => safe_params[:team_id], :user_id => @user.id})
      @membership.save!
      render json: @membership, status: 201
    else
      @invitation = Invitation.where({:email => safe_params[:email]}).first_or_create do |invitation|
        invitation.email = safe_params[:email]
      end
      @invitation.teams << Team.where({:id => safe_params[:team_id]}).first
      if @invitation.save!
        UserNotifier.send_signup_email(current_user, @invitation, safe_params[:email]).deliver_now
        render json: @invitation, status: 201
      end
    end

  end

  def destroy
    @membership = Membership.find(params[:id])
    respond_to do |format|
      if @membership.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:membership).permit(:team_id, :email)
  end
end
