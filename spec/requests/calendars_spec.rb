require 'spec_helper'

describe "Calendar pages" do
  it "shows daily calendar" do
    VCR.use_cassette('calendar/daily') do
      visit "/states/tx/calendars/daily"
      page.should have_content("Texas Daily Prayer List")
    end
  end

  it "allows subscription to state daily email list" do
    VCR.use_cassette('calendar/subscription_daily') do
      visit "/states/tx/calendars/daily"
      fill_in 'Email', with: 'joe@smith.com' 
      click_on 'Subscribe'
      page.should have_content('Success')
    end
  end

  it "subscribe gives error without email" do
    VCR.use_cassette('calendar/error_no_email') do
      visit "/states/tx/calendars/daily"
      click_on 'Subscribe'
      page.should have_content('Error')
    end
  end

end
