require 'rails_helper'

RSpec.describe Membership, :type => :model do
  it 'has a valid factory' do
    expect(build(:memberships)).to be_valid
  end

  it 'must not accept null team' do
    expect(build(:memberships, team: nil)).not_to be_valid
  end

  it 'must not accept null user' do
    expect(build(:memberships, user: nil)).not_to be_valid
  end
end
