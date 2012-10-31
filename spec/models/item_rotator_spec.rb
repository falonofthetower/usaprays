require 'spec_helper'

# Given a set of items, ItemRotator
# rotates through them at a velocity of
# of @rate per @tick
describe ItemRotator do
  let :rotator do
    rotator = ItemRotator.new([:a, :b, :c, :d, :e, :f, :g])
  end

  context "#selected_items" do
    it "returns selected item" do
      rotator.selected_items.should == [:a]
    end

    it "rotates once" do
      rotator.rotations = 1
      rotator.selected_items.should == [:b]
    end

    it "rotates twice" do
      rotator.rotations = 2
      rotator.selected_items.should == [:c]
    end

    it "loops around" do
      rotator.rotations = 7
      rotator.selected_items.should == [:a]
    end

    it "loops around and keeps going" do
      rotator.rotations = 8
      rotator.selected_items.should == [:b]
    end

    it "returns multiple items with no rotation" do
      rotator.rate = 3
      rotator.selected_items.should == [:a, :b, :c]
    end
    
    it "rotates at greater rate" do
      rotator.rate = 3
      rotator.rotations = 1
      rotator.selected_items.should == [:d, :e, :f]
    end
    
    it "rotates around at greater rate" do
      rotator.rate = 3
      rotator.rotations = 2
      rotator.selected_items.should == [:g, :a, :b]
    end

    it "returns same selected items when called multiple times" do
      rotator.rate = 3
      first_set = rotator.selected_items
      rotator.selected_items.should == first_set
    end
  end

  context "#pointer_after_rotate" do
    it "shows new location after rotation" do
      rotator.rotations = 1
      rotator.pointer_after_rotate.should == 1
    end

    it "shows same location with no rotation" do
      rotator.pointer_after_rotate.should == 0
    end
  end

end
