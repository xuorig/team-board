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
    self.board.notify_board_change({:board_item => self.id})
  end

end
