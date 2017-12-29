require 'spec_helper'

describe LeaderFinder do
  it "finds all leaders in a state" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "FL", chamber: 'S', import_timestamp: timestamp)

    LeaderFinder.by_state('TX').first.statecode.should == 'TX'
  end

  it "finds 2 us senators" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    2.times do
      create(:leader, statecode: "TX", legtype: "FL", chamber: 'S', import_timestamp: timestamp)
    end

    LeaderFinder.us_senate('TX').length.should == 2
  end

  it "finds us senators" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "FL", chamber: 'S', import_timestamp: timestamp)

    LeaderFinder.us_senate('TX').first.legtype.should == 'FL'
    LeaderFinder.us_senate('TX').first.chamber.should == 'S'
  end

  it "finds us house" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "FL", chamber: "H", import_timestamp: timestamp)

    LeaderFinder.us_house('TX').first.legtype.should == 'FL'
    LeaderFinder.us_house('TX').first.chamber.should == 'H'
  end

  it "finds us congress" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "FL", chamber: "H", import_timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "FL", chamber: "H", import_timestamp: timestamp)

    us_congress = LeaderFinder.us_senate('tx') +
      LeaderFinder.us_house('tx')
    LeaderFinder.us_congress('tx').should == us_congress
  end

  it "finds state senate" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "SL", chamber: "S", import_timestamp: timestamp)

    LeaderFinder.state_senate('tx').first.legtype == 'SL'
    LeaderFinder.state_senate('tx').first.chamber == 'S'
  end

  it "finds state house" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    create(:leader, statecode: "TX", legtype: "SL", chamber: "H", import_timestamp: timestamp)

    LeaderFinder.state_house('tx').first.legtype == 'SL'
    LeaderFinder.state_house('tx').first.chamber == 'H'
  end

  it "finds a single leader" do
    timestamp = Time.zone.now
    ImportRecord.create(timestamp: timestamp)
    leader = create(:leader, statecode: "TX", legtype: "FL", chamber: "S", firstname: "Bob", lastname: "Barnes", prefix: "", uid: "1234", import_timestamp: timestamp)
    Slug.create(path: leader.slug, know_who_id: "1234")

    LeaderFinder.find(leader.slug).slug.should == leader.slug
  end
end
