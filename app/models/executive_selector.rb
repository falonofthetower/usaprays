class ExecutiveSelector
  attr_accessor :state_code, :date

  def initialize(state, date)
    @state_code = state.to_param
    @date = date
  end

  def self.for_day(state_code, date)
    Refinery::Executives::Executive.where(state_code: nil).order("position") +
    Refinery::Executives::Executive.where(state_code: state_code).order("position") 
  end

  def leader_type
    "Executive"
  end
end
