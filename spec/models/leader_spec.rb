require 'spec_helper'

describe Leader do
  it "builds itself from a hash" do
    data = {
      "email" => "foo@bar.com",
      "first_name" => "Bob"
    }
    leader = Leader.new(data)
    "#{leader.first_name} - #{leader.email}".should == "Bob - foo@bar.com"
  end

  it "returns its own state" do
    LeaderFinder.us_house('tx')
    ron = LeaderFinder.find('us-rep-tx-louie-gohmert')
    ron.state.should == UsState.new('tx')
  end
end
