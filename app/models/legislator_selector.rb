class LegislatorSelector
  attr_accessor :state_code

  def initialize(state)
    @state_code = state.to_param
  end

  def self.today(state)
    selected = LegislatorSelector.new(state)
    selected.us_congress +
    selected.state_senate +
    selected.state_house
  end

  def us_congress
    rotation_select('us_congress')
  end

  def state_senate
    rate = (@state_code == 'ne' ? 5 : 2)
    rotation_select('state_senate', rate)
  end

  def state_house
    rotation_select('state_house', 3)
  end

  def rotation_select(chamber, rate=1)
    name = "#{@state_code}_#{chamber}"
    leaders = LeaderFinder.send(chamber, @state_code)
    Rotation.select(name, leaders, rate)
  end

end
