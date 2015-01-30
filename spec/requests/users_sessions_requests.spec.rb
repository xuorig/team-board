require 'spec_helper'

describe "GET '/auth/google_oauth2/callback'" do

  before(:each) do
    get "auth/google_oauth2/callback"
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it "should set user_id" do
    expect(session[:user_id]).to eq(User.last.id)
  end

  it "should redirect to root" do
    expect(response).to redirect_to root_path
  end
end

describe "GET '/auth/failure'" do

  it "should redirect to root" do
    get "/auth/failure"
    expect(response).to redirect_to root_path
  end
end