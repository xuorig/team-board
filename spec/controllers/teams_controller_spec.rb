require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do
  render_views
  describe "index" do
    before do
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
      user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
      xhr :get, :index, format: :json
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the search finds results" do
      it 'should 200' do
        puts response.body
        expect(response.status).to eq(200)
      end
    end
  end

end
