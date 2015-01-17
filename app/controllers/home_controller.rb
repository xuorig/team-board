class HomeController < ApplicationController
  def index
    if current_user.nil?
      render :layout => "splash"
    else
      render :layout => "application"
    end
  end
end
