require 'rails_helper'

RSpec.describe Team, :type => :model do
  it 'has a valid factory' do
    expect(build(:team)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:team, name: nil)).to_not be_valid
  end

  it 'is invalid without an owner' do
  	expect(build(:team, owner: nil)).to_not be_valid
  end

  it 'has no projects when created' do
  	new_team = build(:team)
  	expect(new_team.projects).to be_empty
  end
end
