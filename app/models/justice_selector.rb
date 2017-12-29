class JusticeSelector
  attr_accessor :state_code, :date

  def initialize(state, date)
    @state_code = state.to_param
    @date = date
  end

  def self.for_day(state, date)
    if EdgeDay.new(date).last_day_of_month?
      Refinery::Justices::Justice.all(order: "position", limit: 4)
    else
      Refinery::Justices::Justice.all(order: "position DESC", limit: 5).reverse
    end
  end

  def leader_type
    "Justice"
  end
end
