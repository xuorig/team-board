require 'rails_helper'

RSpec.describe User, :type => :model do

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'must have an email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'has no teams when created' do
    expect(build(:user).teams).to be_empty
  end

  it 'has no projects when created' do
    expect(build(:user).projects).to be_empty
  end

  it 'has all teams also is empty' do
    expect(build(:user).all_teams()).to be_empty
  end

  it 'has all projects also is empty' do
    expect(build(:user).all_projects()).to be_empty
  end

  it 'has no owned boards' do
    expect(build(:user).owned_boards).to be_empty
  end

  it 'has no board items' do
    expect(build(:user).board_items).to be_empty
  end

  # Tests with team owner
  # These are more about controller tests...........

  it 'has teams when is team owner' do
    team_owner = create(:team_owner)
    expect(team_owner.all_teams()).not_to be_empty
  end

  it 'has managed teams when is team owner' do
    team_owner = create(:team_owner)
    expect(team_owner.managed_teams).not_to be_empty
    expect(team_owner.owned).not_to be_empty
    expect(team_owner.managed_teams).to include(*team_owner.owned)
  end

  it 'has teams when is team manager' do
    team_manager = create(:team_manager)
    expect(team_manager.managed_teams).not_to be_empty
    expect(team_manager.owned).to be_empty
    expect(team_manager.teams).not_to be_empty
    expect(team_manager.teams).to include(*team_manager.managed_teams)
  end

  it 'has teams when is team member' do
    team_member = create(:team_member)
    expect(team_member.managed_teams).to be_empty
    expect(team_member.owned).to be_empty
    expect(team_member.teams).not_to be_empty
  end

  it 'has projects when is project owner' do
    project_owner = create(:project_owner)
    expect(project_owner.owned_projects).not_to be_empty
  end

  it 'has projects when is project member' do
    project_member = create(:project_member)
    expect(project_member.projects).not_to be_empty
    expect(project_member.owned_projects).to be_empty
  end

  it 'can be found from omniauth' do
    auth = OmniAuth::AuthHash.new
    auth.info = OmniAuth::AuthHash::InfoHash.new
    user = create(:user)
    auth.info["email"] = user.email
    user_from_auth = User.from_omniauth(auth)

    expect(user).to eq(user_from_auth)
  end

  it 'can not have duplicate email' do
    user1 = create(:user, email:"myemail")
    user2 = build(:user, email: "myemail")

    expect(user2).not_to be_valid
  end

end
