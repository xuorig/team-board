class BoardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_project

  def get_project
    @project = Project.find(params[:project_id])
    return @project if @project.users.include?(current_user)
  end

  def index
    @boards = @project.boards
    respond_to do |format|
      format.json {render json: @boards}
    end
  end

  def show
    @board = @project.boards.find(params[:id])
    respond_to do |format|
      format.json {render json: @board}
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
