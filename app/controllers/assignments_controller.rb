class AssignmentsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end

  def show
  end

  # POST /teams
  def create
    safe_params[:user_ids].each do |user_id|
      @assignment = Assignment.create!({:assignee_id => user_id, :board_item_id => safe_params[:board_item_id]})
    end
    render json: @assignment, status: 201
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    respond_to do |format|
      if @assignment.destroy
        format.json { head :no_content, status: :ok }
      else
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  def safe_params
    params.require(:assignment).permit(:board_item_id, :user_ids => [])
  end
end
