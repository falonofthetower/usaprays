class RedisCache
  def self.fetch(endpoint)
    query = $redis.get(endpoint)
    if query.nil?
      $redis.set(endpoint, yield)
      query = $redis.get(endpoint)
    end
    JSON.parse query
  end
end
