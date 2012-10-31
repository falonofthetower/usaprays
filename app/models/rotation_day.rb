class RotationDay
  attr_accessor :start_date, :end_date

  def initialize(args={})
    @start_date = args[:start_date]
    @end_date = args[:end_date]
  end

  def days_between
    (end_date - start_date).to_i
  end

  def non_boundry_days_between
    days = 0
    while end_date > start_date
      days += 1 unless first_day?(end_date) or last_day?(end_date)
      self.end_date -= 1
    end
    days
  end

  def first_day?(date)
    Date.new(date.year, date.month, 1) == date
  end

  def last_day?(date)
    Date.new(date.year, date.next_month.month, 1).prev_day == date
  end

end
