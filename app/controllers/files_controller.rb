class FilesController < ApplicationController
  before_filter :authenticate_user!

  # GET /files
  def index
  end

  # GET /files/:id
  def show
  end

  # POST /files
  def create
  end

  def destroy
  end

  def safe_params
  end
end
