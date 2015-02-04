class TeamsController < ApplicationController
  before_filter :authenticate_user!

  # POST /teams
  def create
    user = User.where(email: safe_params[:email])
    @membership = Membership.new(safe_params[:team_id], user.id)
    @membership.save!
    render json: @membership, status: 201
  end

  def destroy
    user = User.where(email: safe_params[:email])
    @membership = Membership.where({team_id: params[:membership][:team_id], user_id: user.id]})
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
