class LeaderFinder

  def self.find(slug)
    know_who_id = Slug.find_by_path(slug).know_who_id
    chamber = level(slug)

    result = get '{ "PersonIDs": "' + know_who_id + '" }', { chamber: "#{chamber}Government" }
    leader = Leader.new
    leader.setup(result)
    leader
  end

  def self.level(slug)
    if slug.split("-")[0] == "us"
      "US"
    else
      "State"
    end
  end

  def self.by_state(state_code)
    state_congress(state_code) + us_congress(state_code)
  end

  def self.us_senate(state_code)
    get_leaders '{ "Chamber": "US Senate", "State": "' + state_code.upcase + '" }'
  end

  def self.us_house(state_code)
    get_leaders '{ "Chamber": "US House", "State": "' + state_code.upcase + '" }'
  end

  def self.state_senate(state_code)
    get_leaders '{ "Chamber": "State Senate", "State": "' + state_code.upcase + '" }'
  end

  def self.state_house(state_code)
    get_leaders '{ "Chamber": "State House", "State": "' + state_code.upcase + '" }'
  end

  def self.state_congress(state_code)
    get_leaders '{ "Chamber": "State House, State Senate", "State": "' + state_code.upcase + '" }'
  end

  def self.us_congress(state_code)
    get_leaders '{ "Chamber": "US House, US Senate", "State": "' + state_code.upcase + '" }'
  end

  private

  def self.get(params, options={})
    result = client.call(:search_by_id, message: { 'InputString' => json(params) })
    count = Count.first
    count.count += 1
    count.save
    json_result = JSON.parse result.to_json
    hash = JSON.parse json_result["search_by_id_response"]["search_by_id_result"]
    array = hash["KnowWho"][options[:chamber]]
    result = LeaderFormatter.new(array.first).to_hash
    leader = Leader.new
    leader.setup result
    leader
  end

  def self.client
    proxy = ENV["QUOTAGUARDSTATIC_URL"] if ENV["QUOTAGUARDSTATIC_URL"]
    wsdl ='http://knowwho.info/Services/ElectedOfficialsDirectoryService.asmx?WSDL'

    Savon.client do |savon|
      savon.wsdl wsdl
      savon.proxy proxy if proxy
    end
  end

  def self.json(params, page_number=1)
    "{ \"KnowWho\": { \"Customer\": { \"CustomerCode\": \"#{ENV["know_who_key"]}\", \"ServiceLevel\": \"Premium\", \"PageNumber\": #{page_number} }, \"RequestParameters\": #{params} } }"
  end

  def self.get_leaders(params)
    result_set = cached_get(params)
    formatted_result = []
    result_set.each do |leader|
      formatted_result << LeaderFormatter.new(leader).to_hash
    end

    # results = cached_get(endpoint)
    leaders = []
    formatted_result.each do |data|
      leader = Leader.new
      leader.setup(data)
      leaders << Leader.new(leader)
    end
    leaders
  end

  def self.cached_get(endpoint)
    # Rails.cache.delete(endpoint)
    Rails.cache.fetch(endpoint) do
      chamber = !endpoint.scan(/US/).empty? ? "USGovernment" : "StateGovernment"
      finished = false
      page_counter = 1
      result_set = []
      until finished
        results = client.call(:search_by_chamber, message: { 'InputString' => json(endpoint, page_counter) })
        count = Count.first
        count.count += 1
        count.save
        Rails.logger.info "***Requests @#{$requests}***"
        json_result = JSON.parse results.to_json
        hash = JSON.parse json_result["search_by_chamber_response"]["search_by_chamber_result"]
        Rails.logger.error hash["KnowWho"]["Customer"]["ReturnCode"]
        Rails.logger.error results
        if hash["KnowWho"]["Customer"]["ReturnCode"] == "OK"
          result_set += hash["KnowWho"][chamber]
          total_pages = hash["KnowWho"]["Customer"]["TotalPages"]
          finished = (total_pages.to_i == page_counter)
          page_counter += 1
          puts page_counter
          puts result_set.size
        else
          Rails.logger.error hash["KnowWho"]["Customer"]["ReturnCode"]
          Rails.logger.error results
          # result_set = []
          finished = true
        end
      end
      result_set
    end
  end
end
