require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'must not accept null board item' do
    expect(build(:comment, board_item: nil)).not_to be_valid
  end

  it 'must not accept null user' do
    expect(build(:comment, user: nil)).not_to be_valid
  end

  it 'must not accept null content' do
    expect(build(:comment, content: nil)).not_to be_valid
  end
end
