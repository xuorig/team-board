class ManagershipsController < ApplicationController
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
    @managership = Managership.new({:team_id => safe_params[:team_id], :manager_id => user.id})
    @managership.save!
    render json: @managership, status: 201
  end

  def destroy
    user = User.where(email: safe_params[:email])
    @managership = Managership.where({team_id: params[:managership][:team_id], manager_id: user.id}).first
    respond_to do |format|
      if @managership.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @managership.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:managership).permit(:team_id, :email)
  end
end
