class TeamsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :remove_new_invites, :only => [:index]

  def remove_new_invites
    current_user.remove_new_invites
  end

  # GET /teams
  # GET /teams.json
  def index
    render json: current_user.all_teams.to_json(:include => [:owner, :managers]), status: 200
  end

  # GET /teams/:id
  # GET /teams/:id.json
  def show
    team = current_user.all_teams.find(params[:id]).to_json(:current_user => current_user,
                                                          :include => [:owner, :users, :managers, :projects, :pending_invites, :all_users])
    render json: team
  end

  # POST /teams
  def create
    team = Team.new(safe_params.slice(:name, :description))
    team.owner = current_user

    if params[:team][:users]
      params[:team][:users].each do |email|
        existingUser = User.where(email: email)
        user = existingUser.blank? ? User.create!(:email => email) : existingUser.first
        if user != current_user
          team.users << user
        end
      end
    end

    team.save!
    render json: team, status: 201
  end

  def destroy
    @team = current_user.all_teams.find(params[:id])
    raise TeamBoard::InvalidAccess unless @team.owner == current_user

    if @team.destroy
      head :no_content, status => :ok
    else
      render json: @team.errors, :status => :unprocessable_entity
    end
  end

  def safe_params
    params.require(:team).permit(:name, :description, :users => [])
  end
end
