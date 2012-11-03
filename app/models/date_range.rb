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

  private

    class EdgeDay
      attr_accessor :date

      def initialize(date)
        @date = date
      end

      def edge_of_month?
        first_day_of_month? or last_day_of_month?
      end

      private

        def first_day_of_month
          Date.new(date.year, date.month, 1)
        end

        def first_day_of_month?
          first_day_of_month == date
        end

        def last_day_of_month
          Date.new(date.next_month.year, date.next_month.month, 1).prev_day
        end

        def last_day_of_month?
          last_day_of_month == date
        end

    end

end
