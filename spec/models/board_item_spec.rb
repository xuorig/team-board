require 'rails_helper'

RSpec.describe BoardItem, :type => :model do
  it 'has a valid factory' do
    expect(build(:board_item)).to be_valid
  end

  it 'must have a board' do
    expect(build(:board_item, board: nil)).not_to be_valid
  end

  it 'must have a position' do
    expect(build(:board_item, position: nil)).not_to be_valid
  end
end
