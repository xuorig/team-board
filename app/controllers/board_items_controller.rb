class BoardItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_board

  def get_board
    if params[:board_id]
      board = Board.find(params[:board_id])
      if board.project.users_managers_owner.include?(current_user)
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
    @item = BoardItem.find(params[:id]).to_json()
    render json: @item, :status => 200
  end

  def update
    @item = BoardItem.find(params[:id])
    if safe_params[:ui_column] != @item.ui_column     
      @item.remove_from_list
      @item.save
      @item.ui_column = safe_params[:ui_column]
      @item.save
    end
    if safe_params[:position] != @item.position
      @item.insert_at(safe_params[:position])
      @item.save
    end

    respond_to do |format|
      if @item.update!(safe_params.except([:ui_column, :position]))
        format.json { render json: @item, status: :ok }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end

  end

  def create
    @board.items << BoardItem.create!(safe_params)
    render :nothing => true, :status => 201
  end

  def destroy
    @item = BoardItem.find(params[:id])
    respond_to do |format|
      if @item.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:board_item).permit(:title, :note_content, :position, :color, :ui_column)
  end
end
