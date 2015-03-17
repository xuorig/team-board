require 'rails_helper'

RSpec.describe Managership, :type => :model do
    it 'has a valid factory' do
    expect(build(:managerships)).to be_valid
  end

  it 'must not accept null team' do
    expect(build(:managerships, team: nil)).not_to be_valid
  end

  it 'must not accept null user' do
    expect(build(:managerships, user: nil)).not_to be_valid
  end
end
