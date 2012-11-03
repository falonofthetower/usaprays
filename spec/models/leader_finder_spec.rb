require 'spec_helper'

describe LeaderFinder do
  it "finds all leaders in a state" do
    LeaderFinder.by_state('tx').first.state_code.should == 'tx'
  end

  it "finds 2 us senators" do
    LeaderFinder.us_senate('tx').length.should == 2
  end

  it "finds us senators" do
    LeaderFinder.us_senate('tx').first.title.should == 'US Senator'
  end

  it "finds us house" do
    LeaderFinder.us_house('tx').first.title.should == 'US Representative'
  end

  it "finds us congress" do
    us_congress = LeaderFinder.us_senate('tx') +
      LeaderFinder.us_house('tx')
    LeaderFinder.us_congress('tx').should == us_congress
  end

  it "finds state senate" do
    LeaderFinder.state_senate('tx').first.title.should == 'Texas Senator'
  end

  it "finds state house" do
    LeaderFinder.state_house('tx').first.title.should == 'Texas Representative'
  end

  it "finds a single leader" do
    leader = LeaderFinder.us_senate('tx').first
    LeaderFinder.find(leader.slug).slug.should == leader.slug
  end
end
