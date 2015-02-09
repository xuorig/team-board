class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  # GET /projects
  def index
    render json: current_user.projects, status: 200
  end

  # GET /projects/:id
  def show
    @project = current_user.projects.find(params[:id]).to_json(:current_user => current_user,
                                                          :include => [:owner, :users, :managers, :boards])
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(safe_params.slice(:name, :description))
    @project.owner = current_user
    @project.users << current_user
    @project.managers << current_user

    params[:project][:users].each do |email|
      user = User.where(email: email)
      if user.blank?
        user = User.new
        user.email = email
        user.save!
      else
        user = user.first
      end
      if user != current_user
        @project.users << user
      end
    end

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
    params.require(:project).permit(:name, :description, :users => [], :teams => [])
  end
end
