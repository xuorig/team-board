class Board < ActiveRecord::Base
  validates :owner, presence: true
  validates :project, presence: true

  belongs_to :project
  belongs_to :owner, :class_name => "User"
  has_many :items, :class_name => "BoardItem"

  after_save :notify_board_change
  after_create :notify_board_change
  def notify_board_change
    self.class.connection.execute "NOTIFY #{channel}, #{self.class.connection.quote self.to_s}"
  end

  def on_board_change
    self.class.connection.execute "LISTEN #{channel}"
    loop do
      self.class.connection.raw_connection.wait_for_notify do |event, pid, board|
        yield board
      end
    end
  ensure
    self.class.connection.execute "UNLISTEN #{channel}"
  end

  private
  def channel
    "boards_#{id}"
  end

end
