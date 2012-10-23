require 'spec_helper'

describe "UsState" do
  it "knows its name" do
    state = UsState.new('tx')
    state.name.should == "Texas" 
  end

  it "knows its own leaders" do
    VCR.use_cassette('us_state/leaders') do
      state = UsState.new('tx')
      state.leaders.should_not be_empty 
    end
  end
end
