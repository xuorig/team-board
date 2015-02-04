class TeamsController < ApplicationController
  before_filter :authenticate_user!
  # GET /teams
  # GET /teams.json
  def index
    render json: current_user.teams, status: 200
  end

  # GET /teams/:id
  # GET /teams/:id.json
  def show
    team = current_user.teams.find(params[:id]).to_json(:current_user => current_user,
                                                          :include => [:owner, :users, :admins])
    render json: team
  end

  # POST /teams
  def create
  	team = Team.new(safe_params)
    team.owner = current_user
    team.users << current_user
    team.managers << current_user
    team.save!
  	render json: team, status: 201
  end

  def destroy
    @team = current_user.teams.find(params[:id])
    respond_to do |format|
      if @team.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
	  params.require(:team).permit(:name, :description, :users)
  end
end
