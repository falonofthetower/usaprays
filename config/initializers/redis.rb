# For Rails 3
if ENV["REDISCLOUD_URL"]
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

# For Rails 4
# if ENV["REDISCLOUD_URL"]
#     $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
# end
