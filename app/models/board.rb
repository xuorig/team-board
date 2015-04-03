class Board < ActiveRecord::Base
  validates :owner, presence: true
  validates :project, presence: true

  belongs_to :project
  belongs_to :owner, :class_name => "User"
  has_many :items, :class_name => "BoardItem"

  after_save :notify_board_change
  after_create :notify_board_change

  def notify_board_change(change = {:board => true})
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)
      conn.async_exec "NOTIFY #{channel}, '#{change.to_json}'"
    end
  end

  def team
    self.project.team
  end

  def on_board_change
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      conn = connection.instance_variable_get(:@connection)
      begin
        $redis.lpush("opened_board_ids", self.id)
        conn.async_exec "LISTEN #{channel}"
        logger.info 'Starting Listening on channel #{channel}'
        loop do
          conn.wait_for_notify do |event, pid, change|
            yield change
          end
        end
      ensure
        conn.async_exec "UNLISTEN #{channel}"
        $redis.lrem("opened_board_ids", -1, self.id)
        logger.info 'Finished Listening on channel #{channel}'
      end
    end
  end

  private
  def channel
    "boards_#{id}"
  end

end
