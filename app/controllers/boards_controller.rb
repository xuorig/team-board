class BoardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_project

  def get_project
    if params[:project_id]
      project = Project.find(params[:project_id])
      if project.users.include?(current_user)
        @project = project
      else
        @project = nil
      end
    end
  end

  def index
    @boards = @project.boards
    respond_to do |format|
      format.json {render json: @boards}
    end
  end

  def show
    @board = Board.find(params[:id])
    # Check if user is allwowed to see board
    if @board.project.users.include?(current_user)
      @board = @board.to_json(:include => [:items])
      render json: @board, :status => 200
    else
      render :nothing => true, :status => 404
    end
  end

  def create
    @new_board = Board.new(:name => safe_params[:name])
  end

  def destroy
    @board = @project.boards.find(params[:id])
    respond_to do |format|
      if @board.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:board).permit(:name, :description)
  end
end
