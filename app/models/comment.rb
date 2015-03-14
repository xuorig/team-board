class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :board_item
end
