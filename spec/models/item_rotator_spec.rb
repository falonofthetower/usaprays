require 'spec_helper'

describe ItemRotator do
  let :rotator do
    rotator = ItemRotator.new(items: [:a, :b, :c, :d, :e, :f, :g])
  end

  context "#selected_items" do
    context "rotates" do
      it "once" do
        rotator.rotations = 1
        rotator.selected_items.should == [:b]
      end

      it "twice" do
        rotator.rotations = 2
        rotator.selected_items.should == [:c]
      end

      it "at greater rate" do
        rotator.rate = 3
        rotator.rotations = 1
        rotator.selected_items.should == [:d, :e, :f]
      end

      it "around at greater rate" do
        rotator.rate = 3
        rotator.rotations = 2
        rotator.selected_items.should == [:g, :a, :b]
      end
    end

    context "loops" do
      it "around" do
        rotator.rotations = 7
        rotator.selected_items.should == [:a]
      end

      it "and around and keeps going" do
        rotator.rotations = 8
        rotator.selected_items.should == [:b]
      end
    end

    context "returns" do
      it "selected item" do
        rotator.selected_items.should == [:a]
      end

      it "multiple items with no rotation" do
        rotator.rate = 3
        rotator.selected_items.should == [:a, :b, :c]
      end

      it "same selected items when called multiple times" do
        rotator.rate = 3
        first_set = rotator.selected_items
        rotator.selected_items.should == first_set
      end
    end
  end
end
