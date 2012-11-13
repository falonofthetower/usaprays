class JusticeSelector
  attr_accessor :state_code, :date

  def initialize(state, date)
    @state_code = state.to_param
    @date = date
  end

  def self.for_day(state, date)
    Refinery::Justices::Justice.all(order: "position")
  end

  def leader_type
    "Justice"
  end
end
