require 'spec_helper'

describe Rotation do
  let :items do
    [:a, :b, :c, :d, :e, :f]
  end

  let :name do
    'tx_us_senate'
  end

  let :sep_15 do
    Date.new(1972, 9, 15)
  end

  it "doesn't rotate when rotation is current" do
    Rotation.select(name, items)
    Rotation.select(name, items).should == [:a]
  end

  it "rotates when rotation is not current" do
    Rotation.select(name, items, date: sep_15.prev_day)
    Rotation.select(name, items, date: sep_15).should == [:b]
  end

  it "rotates when rotation is a few days old" do
    Rotation.select(name, items, date: sep_15.prev_day(3))
    Rotation.select(name, items, date: sep_15).should == [:d]
  end

  it "returns items for future date" do
    Rotation.select(name, items, date: sep_15)
    Rotation.select(name, items, date: sep_15.next_day(2)).should == [:c]
  end

  it "returns items for more future date" do
    Rotation.select(name, items, date: sep_15)
    Rotation.select(name, items, date: sep_15.next_day(3)).should == [:d]
  end

  it "doesn't rotate on first or last day of month" do
    Rotation.select(name, items, date: Date.new(2012, 10, 30))
    Rotation.select(name, items, date: Date.new(2012, 11, 2)).should == [:b]
  end

end
