require 'rails_helper'

RSpec.describe Team, :type => :model do
  it 'has a valid factory' do
    expect(build(:team)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:team, name: nil)).to_not be_valid
  end

  it 'is invalid without an owner' do
    expect(build(:team, owner: nil)).not_to be_valid
  end

  it 'has no projects when created' do
    new_team = build(:team)
    expect(new_team.projects).to be_empty
  end

  it 'has managership' do
    new_team = create(:team)
    expect(new_team.managership).not_to be_empty
    expect(new_team.managers).to include(new_team.owner)
    expect(new_team.owner.managed_teams).to include(new_team)
  end

  it 'has memberships' do
    new_team = create(:team)
    expect(new_team.memberships).not_to be_empty
    expect(new_team.owner.teams).to include(new_team)
  end
end
