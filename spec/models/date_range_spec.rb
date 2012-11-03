require 'spec_helper'

describe DateRange do
  let :oct_first do
    Date.new(2012, 10, 1)
  end

  let :oct_last do
    Date.new(2012, 10, 31)
  end

  it "knows how many days between start date and end date" do
    rd = DateRange.new(start_date: oct_first, end_date: oct_last)
    rd.days_between.should == 30
  end

  it "knows how many days between start date and end date spanning 2 months" do
    rd = DateRange.new(start_date: oct_first, end_date: oct_last.next_day(15))
    rd.days_between.should == 45
  end

  it "knows how many (non first or last) days between start date and end date" do
    rd = DateRange.new(start_date: oct_first, end_date: oct_last.next_day(15))
    rd.non_edge_days_between.should == 43
  end

  it "returns count of non monthly edge dates for the year" do
    start_date = Date.new(2012,1,1)
    end_date = Date.new(2012,12,31)
    days_in_year = (start_date..end_date).to_a.length
    day_count = days_in_year - (12 * 2)
    date_range = DateRange.new(start_date: start_date, 
                               end_date: end_date)
    date_range.non_edge_days_between.should == day_count
  end
end
