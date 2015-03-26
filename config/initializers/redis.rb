if Rails.env == "development"
  $redis = Redis.new(:host => 'localhost', :port => 6379)
elsif Rails.env == "test"
  $redis = Redis.new(:host => 'localhost', :port => 6379)
elsif Rails.env == "production"
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

# EMPTY OPENED BOARDS
$redis.ltrim("opened_board_ids", 1, 0)