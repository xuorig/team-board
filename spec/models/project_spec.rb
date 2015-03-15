require 'rails_helper'

RSpec.describe Project, :type => :model do
  
  it 'has a valid factory' do
    expect(build(:project)).to be_valid
  end

  it 'must have an owner' do
    expect(build(:project, owner: nil)).not_to be_valid
  end
end
