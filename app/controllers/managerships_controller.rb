class ManagershipsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @managership = Managership.where({team_id: params[:team_id], manager_id: params[:manager_id]})
    if @managership
      render json: @managership, status:200
    end
  end

  def show
  end

  # POST /teams
  def create
    user = User.where(email: safe_params[:email])
    if not user.blank?
      user = user.first
      @managership = Managership.new({:team_id => safe_params[:team_id], :manager_id => user.id})
      @managership.save!
      render json: @managership, status: 201
    else
      @invitation = invite_user true
      if @invitation
        render json: @invitation, status: 201
      else
        render json: @invitation.errors, status: 400
      end
    end

  end

  def destroy
    @managership = Managership.find(params[:id])
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
