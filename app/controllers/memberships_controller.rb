class MembershipsController < ApplicationController
  before_filter :authenticate_user!

  # POST /teams
  def create
    user = User.where(email: safe_params[:email])
    if not user.blank?
      user = user.first
    else
      #Create an empty user shell with email so we can activate his account later when he logs in
      user = User.new
      user.email = safe_params[:email]
      user.save!
    end
    @membership = Membership.new({:team_id => safe_params[:team_id], :user_id => user.id})
    @membership.save!
    render json: @membership, status: 201
  end

  def destroy
    user = User.where(email: safe_params[:email])
    @membership = Membership.where({team_id: params[:membership][:team_id], user_id: user.id}).first
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