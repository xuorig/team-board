class HomeController < ApplicationController
  def index
  	dev_authenticate!
    if current_user.nil?
      render :layout => "splash"
    else
      render :layout => "application"
    end
  end
end
