class UsState < Struct.new(:code)

  # All 50 US States
  def self.names
    {"al"=>"Alabama", "ak"=>"Alaska", "az"=>"Arizona", "ar"=>"Arkansas", "ca"=>"California", "co"=>"Colorado", "ct"=>"Connecticut", "de"=>"Delaware", "fl"=>"Florida", "ga"=>"Georgia", "hi"=>"Hawaii", "id"=>"Idaho", "il"=>"Illinois", "in"=>"Indiana", "ia"=>"Iowa", "ks"=>"Kansas", "ky"=>"Kentucky", "la"=>"Louisiana", "me"=>"Maine", "md"=>"Maryland", "ma"=>"Massachusetts", "mi"=>"Michigan", "mn"=>"Minnesota", "ms"=>"Mississippi", "mo"=>"Missouri", "mt"=>"Montana", "ne"=>"Nebraska", "nv"=>"Nevada", "nh"=>"New Hampshire", "nj"=>"New Jersey", "nm"=>"New Mexico", "ny"=>"New York", "nc"=>"North Carolina", "nd"=>"North Dakota", "oh"=>"Ohio", "ok"=>"Oklahoma", "or"=>"Oregon", "pa"=>"Pennsylvania", "ri"=>"Rhode Island", "sc"=>"South Carolina", "sd"=>"South Dakota", "tn"=>"Tennessee", "tx"=>"Texas", "ut"=>"Utah", "vt"=>"Vermont", "va"=>"Virginia", "wa"=>"Washington", "wv"=>"West Virginia", "wi"=>"Wisconsin", "wy"=>"Wyoming"}
  end

  def self.northeast
    regions %w[ct ma me nh nj ny pa ri vt]
  end

  def self.midwest
    regions %w[ia il in ks mi mn mo nd ne oh sd wi]
  end

  def self.south
    regions %w[al ar de fl ga ky la md ms nc ok sc tn tx va wv]
  end

  def self.west
    regions %w[ak az ca co hi id mt nm nv or ut wa wy]
  end

  def self.cc_states
    # States that have a Capitol Commission State Director (accepts donations)
    %w[ ar ca co ga il in ks ky la md mi mo nc oh ok pa sc sd tn tx va wv wy ]
  end

  def self.regions(region_codes)
    region_codes.collect {|code| UsState.new(code)}
  end

  def name
    UsState.names[code.to_s]
  end

  def leaders
    LeaderFinder.by_state(code)
  end

  def us_senate
    LeaderFinder.us_senate(code)
  end

  def us_house
    LeaderFinder.us_house(code)
  end

  def state_senate
    LeaderFinder.state_senate(code)
  end

  def state_house
    LeaderFinder.state_house(code)
  end

  def to_param
    code
  end

end
