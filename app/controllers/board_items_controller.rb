class BoardItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_board
  before_filter :get_limit

  def get_limit
    @limit = params[:limit] or nil
  end

  def get_board
    if params[:board_id]
      board = Board.find(params[:board_id])
      if board.project.all_users.include?(current_user)
        @board = board
      else
        @board = nil
      end
    end
  end

  def index
    if @board
      @boardItems = @board.items
    else
      if params[:has_due_date]
        @boardItems = current_user.board_items.where("board_items.due_date IS NOT NULL").limit(@limit)
      elsif params[:due_soon]
        @boardItems = current_user.board_items.due_soon.limit(@limit)
      else
        @boardItems = current_user.board_items
      end
    end
    render json: @boardItems, :status => 200
  end

  def show
    @item = BoardItem.find(params[:id]).to_json()
    render json: @item, :status => 200
  end

  def update
    @item = BoardItem.find(params[:id])
    if safe_params[:ui_column] != @item.ui_column or safe_params[:position] != @item.position
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
      @item.board.notify_board_change({:data => {:position_changed => true}, :user_id => current_user.id})
    end

    respond_to do |format|
      if @item.update!(safe_params.except([:ui_column, :position]))
        @item.board.notify_board_change({:data => {:board_item => @item.id}, :user_id => current_user.id})
        format.json { render json: @item, status: :ok }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @item = BoardItem.new(safe_params)
    @board.items << @item
    @board.notify_board_change(:data => {:new_item => true}, :user_id => current_user.id)
    render json: @item, :status => 201
  end

  def destroy
    @item = BoardItem.find(params[:id])
    respond_to do |format|
      if @item.destroy
        @board.notify_board_change(:new_item => true, :userId => current_user.id)
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:board_item).permit(:title, :note_content, :due_date, :position, :color, :ui_column)
  end
end
