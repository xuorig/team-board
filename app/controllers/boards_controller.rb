require 'teamboard/sse'

class BoardsController < ApplicationController
  include ActionController::Live

  before_filter :authenticate_user!
  before_filter :get_project
  before_filter :set_num
  before_filter :check_privileges!, only: [:create]

  def set_num
    @limit = params[:limit]
  end

  def get_project
    if params[:project_id]
      project = Project.find(params[:project_id])
      if project.all_users.include?(current_user)
        @project = project
      else
        @project = nil
      end
    end
  end

  def check_privileges!
    if @project.team.owner == current_user or @project.team.managers.include?(current_user)
      return
    else
      raise "Must be manager or owner to create a board"
    end
  end

  def events
    @board = current_user.boards.find(params[:id])
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream, event: "changed")

    @board.on_board_change do |change|
      change = JSON.parse change
      sse.write({change: change, user: current_user.id})
    end

    rescue IOError, ClientDisconnected
    ensure
      response.stream.close
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
      @board = @board.to_json(:include => {:items => {:include => :assignees}, :team => {}})
      render json: @board, :status => 200
    else
      render :nothing => true, :status => 404
    end
  end

  def create
    raise TeamBoard::InvalidAccess unless @project.team.owner_managers.include?(current_user)
    @new_board = Board.new(:name => safe_params[:name], 
      :description => safe_params[:description], :project_id => safe_params[:project_id])
    @new_board.owner = current_user
    @new_board.save!
    render json: @board, :status => 201
  end

  def destroy
    raise TeamBoard::InvalidAccess unless @project.team.owner_managers.include?(current_user)
    @board = @project.boards.find(params[:id])
    @board.destroy
    head :no_content, status: :ok
  end

  def safe_params
    params.require(:board).permit(:name, :description, :project_id)
  end

  private
  def sse(object, options = {})
    (options.map{|k,v| "#{k}: #{v}" } << "data: #{JSON.dump object}").join("\n") + "\n\n"
  end
end
