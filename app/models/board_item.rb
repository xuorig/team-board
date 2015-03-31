class BoardItem < ActiveRecord::Base
  validates :board, presence: true
  validates :position, presence: true

  belongs_to :board
  acts_as_list :scope => [:board_id, :ui_column]
  has_many :comments, :dependent => :destroy

  has_many :assignments, :dependent => :destroy
  has_many :assignees, :source => :user, :through => :assignments

  scope :due_soon, -> { where("board_items.due_date IS NOT NULL").where(:due_date => DateTime.now..1.week.from_now) }

  after_create :notify_board_change
  after_destroy :notify_board_change
  after_save :notify_board_change

  def notify_board_change
    if (self.position_changed? or self.ui_column_changed?)
      notif = {:position_changed => true}
    else
      notif = {:board_item => self.id}
    end
    self.board.notify_board_change(notif)
  end

end
