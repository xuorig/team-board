require 'rails_helper'

RSpec.describe Board, :type => :model do
  it 'has a valid factory' do
    expect(build(:board)).to be_valid
  end

  it 'must have an owner' do
    expect(build(:board, owner: nil)).not_to be_valid
  end

  it 'must have a project' do
    expect(build(:board, project: nil)).not_to be_valid
  end
end
