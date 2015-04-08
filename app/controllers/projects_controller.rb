class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  # GET /projects
  def index
    render json: current_user.all_projects.to_json(:include => [:owner]), :status => 200
  end

  # GET /projects/:id
  def show
    @project = current_user.all_projects
    @project = @project.find(params[:id]).to_json({:include => {:users => {}, :team => {}, :boards => {:include => :owner}}})
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(safe_params.slice(:name, :description))
    @project.owner = current_user

    @team = params[:project][:team_id] != nil ? Team.find(params[:project][:team_id]) : nil
    if @team
      raise TeamBoard::InvalidAccess unless @team.owner_managers.include?(current_user)
    end

    @project.team = @team

    # TODO Add extra project members
    sample_board = Board.new(:name => safe_params[:name] + " Board", :description => "This is an auto generated board for your project.", 
                              :owner => current_user)
    
    @project.boards << sample_board

    @project.save!
    render json: @project, :status => 201
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    raise TeamBoard::InvalidAccess unless @project.team.owner_managers.include?(current_user)
    @project.destroy
    head :no_content, :status => :ok
  end

  def safe_params
    params.require(:project).permit(:name, :description, :team_id)
  end
end
