class Assignment < ActiveRecord::Base
  belongs_to :user, :foreign_key => :assignee_id
  belongs_to :board_item
end
