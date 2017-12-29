class LeaderSelector
  attr_accessor :state_code, :date

  def initialize(state, date)
    @state_code = state.to_param
    @date = date
  end

  def self.for_day(state, date)
    leaders = LeaderSelector.new(state, date).select
    while leaders.length < 6
      leaders<< Leader.new
    end
    leaders
  end

  def select
    if first_day_of_month?
      ExecutiveSelector.for_day(state_code, date)
    elsif last_days_of_month?
      JusticeSelector.for_day(state_code, date)
    else
      LegislatorSelector.for_day(state_code, date)
    end
  end

  private

    def first_day_of_month?
      EdgeDay.new(date).first_day_of_month?
    end

    def last_days_of_month?
      EdgeDay.new(date).last_days_of_month?
    end
end
