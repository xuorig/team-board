class UsersController < ApplicationController
  # GET /users
  def index
  	if params[:email]
  		@user = User.where(email: params[:email])
  		if @user.blank?
  		  render :nothing => true, :status => 404
  		else
		  render :nothing => true, :status => 200
		end
	end
  end

  def show
    user = User.find(params[:id])
    render json: user, :status => 200
  end
end
