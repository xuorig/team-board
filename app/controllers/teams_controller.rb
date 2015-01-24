class TeamsController < ApplicationController
  before_filter :authenticate_user!
  # GET /teams
  # GET /teams.json
  def index
    render json: current_user.teams
  end

  # GET /teams/:id
  # GET /teams/:id.json
  def show
    render json: current_user.teams.find(params[:id])
  end

  # POST /teams
  def create
  	team = Team.create!(safe_params)
  	render json: task, status: 201
  end

  def safe_params
	params.require(:name).permit(:description)
  end
end
