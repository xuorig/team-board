class FilesController < ApplicationController
  before_filter :authenticate_user!

  # CHANGE THIS ALLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL

  # GET /files
  def index
    client = Google::APIClient.new
    client.authorization.access_token = current_user.oauth_token
    drive = client.discovered_api('drive', 'v2')

    result = Array.new
    page_token = nil
    begin
      parameters = {}
      if page_token.to_s != ''
        parameters['pageToken'] = page_token
      end
      api_result = client.execute(
        :api_method => drive.files.list,
        :parameters => parameters)
      if api_result.status == 200
        files = api_result.data
        result.concat(files.items)
        page_token = files.next_page_token
      else
        puts "An error occurred: #{result.data['error']['message']}"
        page_token = nil
      end
    end while page_token.to_s != ''
    result

    render json: result, :status => 200
  end

  # GET /files/:id
  def show
    render json: current_user.all_projects.to_json(:include => [:owner]), :status => 200
  end

  # POST /files
  def create
    render json: current_user.all_projects.to_json(:include => [:owner]), :status => 200
  end

  def destroy
    render json: current_user.all_projects.to_json(:include => [:owner]), :status => 200
  end

  def safe_params
    # params.require(:project).permit(:name, :description, :team_id)
  end
end
