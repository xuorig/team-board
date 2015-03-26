workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)
 
preload_app!
 
rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'
 
on_worker_boot do |index|
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
        Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(config)
  end

  #only one worker should start heartbeat
  create_heartbeat if index.to_i==0
end

# HeartBeat Thread To Kill SSE Threads 
# because of rails apparently not getting FIN packet
# Channels to poke are kept and updated in redis
def create_heartbeat
  heartbeat = Thread.new do
    begin
      hb = {"hb": true}
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        conn = connection.instance_variable_get(:@connection)
        loop do
          opened_boards = $redis.lrange("opened_board_ids", 0, -1)
          puts 'Currently HeartBeating towards channels: #{opened_boards}'
          puts opened_boards
          opened_boards.each do |board_id|
            conn.async_exec "NOTIFY boards_#{board_id}, '#{hb.to_json}'"
          end
          sleep 20.seconds
        end
      end
    ensure
    end
  end
end