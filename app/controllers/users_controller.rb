class UsersController < ApplicationController

  # GET /users?email=
  def index
  	if params[:email]
  		@user = User.where(email: params[:email])
  		if @user.blank? or not @user.first.active
  		  render :nothing => true, :status => 404
  		else
		    render :nothing => true, :status => 200
      end 
		end
  end

  def show
    if params[:id] == 'me' && current_user
      @user = current_user
    end
    raise ActiveRecord::RecordNotFound unless @user
    render json: @user, :status => 200
  end
end
