class LegislatorSelector
  attr_accessor :state_code, :date

  ROTATE_SINCE = Date.new(2012, 1, 1)

  def initialize(state, date)
    @state_code = state.to_param
    @date = date
  end

  def self.for_day(state, date)
    selected = LegislatorSelector.new(state, date)
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

  def leader_type
    "Legislator"
  end

  private

    def rotation_select(chamber, rate=1)
      name = "#{@state_code}_#{chamber}"
      leaders = LeaderFinder.send(chamber, @state_code)
      selected_items(leaders, rate)
    end

    def selected_items(leaders, rate)
      ItemRotator.new(
        items: leaders, 
        rate: rate,
        rotations: number_of_days).selected_items
    end

    def number_of_days
      DateRange.new(
        start_date: ROTATE_SINCE,
        end_date: date).non_edge_days_between
    end
end
