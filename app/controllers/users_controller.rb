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
      if cookies[:first_time_done]
        @user = current_user.to_json(:methods => [:new_teams])
      else
        @user = current_user.to_json(:methods => [:new_teams, :first_login])
        cookies[:first_time_done] = "yes"
      end
    end
    raise ActiveRecord::RecordNotFound unless @user
    render json: @user, :status => 200
  end
end
