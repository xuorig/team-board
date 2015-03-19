class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_board_item

  def get_board_item
    if params[:board_item_id]
      boardItem = BoardItem.find(params[:board_item_id])
      if boardItem.board.project.all_users.include?(current_user)
        @boardItem = boardItem
      else
        @boardItem = nil
      end
    end
  end

  def index
    if @boardItem
      @comments = @boardItem.comments.to_json(:include => [:user])
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
    @boardItem.comments << Comment.new(:user => current_user, :content => safe_params[:content])
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
