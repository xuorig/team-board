class Assignment < ActiveRecord::Base
  validates :user, presence: true
  validates :board_item, presence: true

  belongs_to :user, :foreign_key => :assignee_id
  belongs_to :board_item
end
