require 'httparty'

class LeaderFinder
  include HTTParty
  base_uri 'api.publicservantsprayer.org'

  def self.find(slug)
    result = get("/v1/leaders/#{slug}")
    leader = Leader.new
    leader.setup(result)
    leader
  end

  # temp
  def self.get_result(slug)
    result = get("/v1/leaders/#{slug}")
  end

  def self.by_state(state_code)
    get_leaders "/v1/states/#{state_code}/leaders"
  end

  def self.us_senate(state_code)
    get_leaders "/v1/states/#{state_code}/leaders/us_senate"  
  end

  def self.us_house(state_code)
    get_leaders "/v1/states/#{state_code}/leaders/us_house"  
  end

  def self.state_senate(state_code)
    get_leaders "/v1/states/#{state_code}/leaders/state_senate"  
  end

  def self.state_house(state_code)
    get_leaders "/v1/states/#{state_code}/leaders/state_house"  
  end

  def self.us_congress(state_code)
    us_senate(state_code) + us_house(state_code)
  end

  def self.get_leaders(endpoint)
    results = get(endpoint)
    leaders = []
    results.each do |data|
      leader = Leader.new
      leader.setup(data)
      leaders << Leader.new(leader)
    end
    leaders
  end

end
