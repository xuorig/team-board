require 'rails_helper'

RSpec.describe Team, :type => :model do
  it 'has a valid factory' do
    expect(build(:team)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:team, name: nil)).to_not be_valid
  end
end
