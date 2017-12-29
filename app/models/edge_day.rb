class EdgeDay
  attr_accessor :date

  def initialize(date)
    @date = date
  end

  def edge_of_month?
    first_day_of_month? || last_day_of_month? || second_to_last_day_of_month?
  end

  def first_day_of_month?
    first_day_of_month == date
  end

  def last_day_of_month?
    last_day_of_month == date
  end

  def last_days_of_month?
    last_day_of_month? || second_to_last_day_of_month?
  end

  def second_to_last_day_of_month?
    second_to_last_day_of_month == date
  end

  private

    def first_day_of_month
      Date.new(date.year, date.month, 1)
    end

    def last_day_of_month
      Date.new(date.next_month.year, date.next_month.month, 1).prev_day
    end

    def second_to_last_day_of_month
      Date.new(date.next_month.year, date.next_month.month, 1) - 2
    end
end
