class BoardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_project

  def get_board
    if params[:board_id]
      board = Board.find(params[:board_id])
      if board.users.include?(current_user)
        @board = board
      else
        @board = nil
      end
    end
  end

  def index
    @items = @board.items
    respond_to do |format|
      format.json {render json: @items}
    end
  end

  def show
    @item = BoardItem.find(params[:id])
    # Check if user is allwowed to see board
    if @board.users_managers_owner.include?(current_user)
      @board = @board.to_json(:include => [:items])
      render json: @board, :status => 200

  end

  def create
    @board.items << BoardItem.create!(safe_params)
    render :nothing => true, :status => 202
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
    params.require(:board_item).permit(:title, :note_content, :position, :color)
  end
end
