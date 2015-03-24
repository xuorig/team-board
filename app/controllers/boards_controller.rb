require 'teamboard/sse'

class BoardsController < ApplicationController
  include ActionController::Live

  before_filter :authenticate_user!
  before_filter :get_project
  before_filter :set_num

  def set_num
    @limit = params[:limit]
  end

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

  def events
    @board = current_user.boards.find(params[:id])
    response.headers['Content-Type'] = 'text/event-stream'
    sse = TeamBoard::SSE.new(response.stream)

    @board.on_board_change do |slide|
      sse.write({board: @board}, {event: 'changed'})
    end
    rescue IOError
      # Client Disconnected
    ensure
      sse.close
  end

  def index
    if @project
      @boards = @project.boards
    else
      @boards = current_user.boards
      if params[:recently_updated]
        @boards = current_user.boards.order("updated_at DESC")
      end
    end
    @boards = @boards.limit(@limit)
    render json: @boards, :status => 200
  end

  def show
    @board = Board.find(params[:id])
    # Check if user is allwowed to see board
    if @board.project.all_users.include?(current_user)
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
