class DateRange
  attr_accessor :start_date, :end_date

  def initialize(args)
    @start_date = args[:start_date]
    @end_date = args[:end_date]
  end

  def days_between
    (end_date - start_date).to_i
  end

  def non_edge_days_between
    days = 0
    test_date = start_date
    while test_date <= end_date
      days += 1 unless EdgeDay.new(test_date).edge_of_month?
      test_date += 1
    end
    days
  end
end
