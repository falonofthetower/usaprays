require 'spec_helper'

describe LegislatorSelector do
  let :state do
    state = UsState.new('tx')
  end

  it "returns an array of one or more members of the US Congress" do
    VCR.use_cassette "legislator_selector/array_members" do
      legislators = LegislatorSelector.new(state).us_congress
      legislators.first.title.include?("US ").should be_true
    end
  end

  it "returns different set of US Congress each day" do
    VCR.use_cassette "legislator_selector/us_congress" do
      todays_leaders = LegislatorSelector.new(state).us_congress
      time_travel_to(Date.tomorrow) do
        todays_leaders.should_not == LegislatorSelector.new(state).us_congress
      end
    end
  end

  it "returns an array of state senate" do
    VCR.use_cassette "legislator_selector/state_senate" do
      legislators = LegislatorSelector.new(state).state_senate
      legislators.first.title.should == "Texas Senator"
    end
  end

  it "returns 2 state senators for nebraska" do
    VCR.use_cassette "legislator_selector/nebraska_senate" do
      state = UsState.new('ne')
      legislators = LegislatorSelector.new(state).state_senate
      legislators.length.should == 2
    end
  end

  it "returns 2 different senators each day for nebraska" do
    VCR.use_cassette "legislator_selector/nebraska_senate2" do
      state = UsState.new('ne')
      todays_leaders = LegislatorSelector.new(state).us_congress
      time_travel_to(Date.tomorrow) do
        tomorrows_leaders = LegislatorSelector.new(state).us_congress
        todays_leaders.include?(tomorrows_leaders.first).should be_false
        todays_leaders.include?(tomorrows_leaders.last).should be_false
      end
    end
  end

  it "returns an array of state house members" do
    VCR.use_cassette "legislator_selector/state_house" do
      legislators = LegislatorSelector.new(state).state_house
      legislators.first.title.should == "Texas Representative"
    end
  end

  it "returns an array of todays legislators" do
    VCR.use_cassette "legislator_selector/todays_legislators" do
      legislators = LegislatorSelector.new(state).us_congress +
        LegislatorSelector.new(state).state_senate +
        LegislatorSelector.new(state).state_house
      LegislatorSelector.today(state).should == legislators
    end
  end
end
