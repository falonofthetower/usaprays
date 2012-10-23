require 'spec_helper'

describe Rotation do
  let :rotation do
    items = [:a, :b, :c, :d, :e, :f]
    Rotation.new(pointer: 0, rate: 1, items: items)
  end

  it "doesn't rotate when rotation is current" do
    rotation.last_rotated_on = Date.current
    rotation.selected_items.should == [:a]
  end

  it "rotates when rotation is not current" do
    rotation.last_rotated_on = Date.yesterday
    rotation.selected_items.should == [:b]
  end

  it "rotates when rotation is a few days old" do
    rotation.last_rotated_on = Date.current - 3
    rotation.selected_items.should == [:d]
  end
end
