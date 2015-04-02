class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :user, presence: true
  validates :board_item, presence: true

  belongs_to :user
  belongs_to :board_item

  after_create :notify_board_change

  def notify_board_change
    self.board_item.notify_board_change
  end
end
