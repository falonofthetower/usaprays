require 'spec_helper'

# Given a set of items, ItemRotator
# rotates through them at a velocity of
# of @rate per @tick
describe ItemRotator do
  let :rotator do
    rotator = ItemRotator.new
    rotator.items = [:a, :b, :c, :d, :e, :f, :g]
    rotator
  end

  it "returns selected items" do
    rotator.rate = 3
    rotator.pointer = 0
    rotator.selected_items.should == [:a, :b, :c]
  end
  
  it "rotates items on one tick" do
    rotator.rate = 3
    rotator.pointer = 0
    rotator.tick!
    rotator.selected_items.should == [:d, :e, :f]
  end
  
  it "rotates items twice on two ticks" do
    rotator.rate = 3
    rotator.pointer = 0
    rotator.tick!
    rotator.tick!
    rotator.selected_items.should == [:g, :a, :b]
  end

  context '#pointer' do 
    it 'loops back around' do
      rotator.rate = 1
      rotator.pointer = rotator.items.length - 1
      rotator.tick!
      rotator.pointer.should == 1
    end

    it 'loops back at larger rate' do
      rotator.rate = 3
      rotator.pointer = rotator.items.length - 1
      rotator.tick!
      rotator.pointer.should == 3
    end
  end

end
