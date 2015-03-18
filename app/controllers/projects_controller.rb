class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  # GET /projects
  def index
    render json: current_user.all_projects.to_json(:include => [:owner]), :status => 200
  end

  # GET /projects/:id
  def show
    @project = current_user.all_projects
    @project = @project.find(params[:id]).to_json(:include => [:owner, :all_users, :boards])
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(safe_params.slice(:name, :description))
    @project.owner = current_user

    @team = Team.find(params[:project][:team_id])
    @project.team = @team

    # TODO Add extra project members

    sample_board = Board.new(:name => safe_params[:name], :description => "This is an auto generated board for your project.", 
                              :owner => current_user)
    @project.boards << sample_board

    @project.save!
    render json: @project, status: 201
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    respond_to do |format|
      if @project.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:project).permit(:name, :description, :team_id)
  end
end
