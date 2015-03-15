require 'rails_helper'

RSpec.describe User, :type => :model do

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'must have an email' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'has no teams when created' do
    user = build(:user)
    expect(user.teams).to be_empty
  end

  it 'has no projects when created' do
    user = build(:user)
    expect(user.projects).to be_empty
  end

  it 'has all teams also is empty' do
    user = build(:user)
    expect(user.all_teams()).to be_empty
  end

  it 'has all projects also is empty' do
    user = build(:user)
    expect(user.all_projects()).to be_empty
  end

  it 'has no owned boards' do
    user = build(:user)
    expect(user.owned_boards).to be_empty
  end

  it 'has no board items' do
    user = build(:user)
    expect(user.board_items).to be_empty
  end

  # Tests with team owner

  it 'has teams when is team owner' do
    team_owner = build(:team_owner)
    expect(team_owner.all_teams()).not_to be_empty
  end

  it 'has managed teams when is team owner' do
    team_owner = build(:team_owner)
    expect(team_owner.managed_teams).not_to be_empty
    expect(team_owner.owned).not_to be_empty
    expect(team_owner.managed_teams).to include(*team_owner.owned)
  end

  it 'has teams when is team manager' do
    team_manager = build(:team_manager)
    expect(team_manager.managed_teams).not_to be_empty
    expect(team_manager.owned).to be_empty
    expect(team_manager.teams).not_to be_empty
    expect(team_manager.teams).to include(*team_manager.managed_teams)
  end

  it 'has teams when is team member' do
    team_member = build(:team_member)
    expect(team_member.managed_teams).to be_empty
    expect(team_member.owned).to be_empty
    expect(team_member.teams).not_to be_empty
  end

  xit 'has projects when is project manager' do
  end

  xit 'has projects when is project member' do
  end

  xit 'has boards when is board owner' do
  end

  xit 'has board items when is board item owner' do
  end

end
