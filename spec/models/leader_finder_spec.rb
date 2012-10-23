require 'spec_helper'

describe LeaderFinder do
  it "finds all leaders in a state" do
    VCR.use_cassette "leader_finder/all_leaders" do
      LeaderFinder.by_state('tx').first.state_code.should == 'tx'
    end
  end

  it "finds 2 us senators" do
    VCR.use_cassette "leader_finder/us_senators2" do
      LeaderFinder.us_senate('tx').length.should == 2
    end
  end

  it "finds us senators" do
    VCR.use_cassette "leader_finder/us_senators" do
      LeaderFinder.us_senate('tx').first.title.should == 'US Senator'
    end
  end

  it "finds us house" do
    VCR.use_cassette "leader_finder/us_house" do
      LeaderFinder.us_house('tx').first.title.should == 'US Representative'
    end
  end

  it "finds us congress" do
    VCR.use_cassette "leader_finder/us_congress" do
      us_congress = LeaderFinder.us_senate('tx') +
        LeaderFinder.us_house('tx')
      LeaderFinder.us_congress('tx').should == us_congress
    end
  end

  it "finds state senate" do
    VCR.use_cassette "leader_finder/state_senate" do
      LeaderFinder.state_senate('tx').first.title.should == 'Texas Senator'
    end
  end

  it "finds state house" do
    VCR.use_cassette "leader_finder/state_house" do
      LeaderFinder.state_house('tx').first.title.should == 'Texas Representative'
    end
  end

  it "finds a single leader" do
    VCR.use_cassette "leader_finder/single_leader" do
      leader = LeaderFinder.us_senate('tx').first
      LeaderFinder.find(leader.slug).slug.should == leader.slug
    end
  end
end
