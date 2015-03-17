class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :user, presence: true
  validates :board_item, presence: true

  belongs_to :user
  belongs_to :board_item
end
