class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_board_item

  def get_board_item
    if params[:board_item_id]
      board_item = BoardItem.find(params[:board_item_id])
      if board_item.board.project.all_users.include?(current_user)
        @board_item = board_item
      else
        @board_item = nil
      end
    end
  end

  def index
    if @board_item
      @comments = @board_item.comments.to_json(:include => [:user])
    else
      limit = params[:limit] or nil
      @comments = Comment.where(:board_item_id => current_user.board_items.map(&:id)).limit(limit).to_json(:include => [:user, :board_item])
    end
    render json: @comments, :status => 200
  end

  def show
    @comment = Comment.find(params[:id]).to_json(:include => [:user])
    render json: @comment, :status => 200
  end

  def update
  end

  def create
    @board_item.comments << Comment.new(:user => current_user, :content => safe_params[:content])
    @board_item.board.notify_board_change({:data => {:board_item => @board_item.id}, :user_id => current_user.id})
    render :nothing => true, :status => 201
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:comment).permit(:content)
  end

end
