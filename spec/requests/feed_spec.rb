require 'spec_helper'

describe "Daily calendar twitter feed" do
  it "Shows current daily calendar" do
    VCR.use_cassette('feed/daily') do
      get "/states/in/calendars/daily/twitter.rss"
      response.should be_success
      response.content_type.should eq("application/rss+xml")
    end
  end
end
