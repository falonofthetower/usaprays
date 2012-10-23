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
end
