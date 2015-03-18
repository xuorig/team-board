require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { build(:user) }
  let(:team_owner) { create(:team_owner) }
  let(:team_manager) { create(:team_manager) }
  let(:team_member) { create(:team_member) }
  let(:project_owner) { create(:project_owner) }
  let(:project_manager) { create(:project_manager) }
  let(:project_member) { create(:project_member) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'must have an email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'has no teams when created' do
    expect(user.teams).to be_empty
  end

  it 'has no projects when created' do
    expect(user.projects).to be_empty
  end

  it 'has all teams also is empty' do
    expect(user.all_teams()).to be_empty
  end

  it 'has all projects also is empty' do
    expect(user.all_projects()).to be_empty
  end

  it 'has no owned boards' do
    expect(user.owned_boards).to be_empty
  end

  it 'has no board items' do
    expect(user.board_items).to be_empty
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
    expect(project_owner.managed_projects).not_to be_empty
    expect(project_owner.projects).not_to be_empty
    expect(project_owner.owned_projects).not_to be_empty
  end

  it 'has projects when is project manager' do
    project_manager = create(:project_manager)
    expect(project_manager.managed_projects).not_to be_empty
    expect(project_manager.projects).not_to be_empty
    expect(project_manager.owned_projects).to be_empty
  end

  it 'has projects when is project member' do
    project_member = create(:project_member)
    expect(project_member.managed_projects).to be_empty
    expect(project_member.projects).not_to be_empty
    expect(project_member.owned_projects).to be_empty
  end

  it 'can be found from omniauth' do
    auth = OmniAuth::AuthHash.new
    auth.info = OmniAuth::AuthHash::InfoHash.new
    auth.info["email"] = "email@test.com"
    user = create(:user)
    user_from_auth = User.from_omniauth(auth)

    expect(user).to eq(user_from_auth)
  end

  it 'can not have duplicate email TEST' do
    user1 = create(:user, email:"myemail")
    user2 = create(:user, email: "notmyemail")
  end

end
