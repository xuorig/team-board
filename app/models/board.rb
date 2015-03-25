class Board < ActiveRecord::Base
  validates :owner, presence: true
  validates :project, presence: true

  belongs_to :project
  belongs_to :owner, :class_name => "User"
  has_many :items, :class_name => "BoardItem"

  after_save :notify_board_change
  after_create :notify_board_change
  def notify_board_change board_item_id
    Board.connection.execute "NOTIFY #{channel}, #{Board.connection.quote board_item_id.to_s}"
  end

  def on_board_change
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)
      begin
        conn.async_exec "LISTEN #{channel}"
        loop do
          conn.wait_for_notify do |event, pid, board_item_id|
            yield board_item_id
          end
        end
      ensure
        conn.async_exec "UNLISTEN #{channel}"
      end
    end
  end

  private
  def channel
    "boards_#{id}"
  end

end
