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
