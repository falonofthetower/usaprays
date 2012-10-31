require 'spec_helper'

describe RotationDay do
  let :oct_first do
    Date.new(2012, 10, 1)
  end

  let :oct_last do
    Date.new(2012, 10, 31)
  end

  it "knows first day of any month" do
    RotationDay.new.first_day?(oct_first).should be_true
  end

  it "knows not first day of any month" do
    RotationDay.new.first_day?(oct_last).should be_false
  end

  it "knows last day of any month" do
    RotationDay.new.last_day?(oct_last).should be_true
  end

  it "knows not last day of any month" do
    RotationDay.new.last_day?(oct_first).should be_false
  end

  it "knows how many days between start date and end date" do
    rd = RotationDay.new(start_date: oct_first, end_date: oct_last)
    rd.days_between.should == 30
  end

  it "knows how many days between start date and end date spanning 2 months" do
    rd = RotationDay.new(start_date: oct_first, end_date: oct_last.next_day(15))
    rd.days_between.should == 45
  end

  it "knows how many (non first or last) days between start date and end date" do
    rd = RotationDay.new(start_date: oct_first, end_date: oct_last.next_day(15))
    rd.non_boundry_days_between.should == 43
  end
end
