require 'rails_helper'

RSpec.describe Assignment, :type => :model do
  it 'has a valid factory' do
    expect(build(:assignment)).to be_valid
  end

  it 'must not accept null board item' do
    expect(build(:assignment, board_item: nil)).not_to be_valid
  end

  it 'must not accept null user' do
    expect(build(:assignment, user: nil)).not_to be_valid
  end
end
