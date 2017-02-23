require 'spec_helper'

describe "Subscription pages" do
  before do
    visit "/states/tx/subscriptions/daily"
  end

  it "shows daily subscription" do
    VCR.use_cassette('subscription/daily') do
      page.should have_content("Texas Daily Prayer List")
    end
  end

  it "allows subscription to state daily email list" do
    VCR.use_cassette('subscription/subscription_daily') do
      fill_in 'Name', with: 'Joe Smith'
      fill_in 'Email', with: 'joe@smith.com'
      click_on 'Subscribe'
      page.should have_content('Success')
    end
  end

  it "subscribe gives error without email" do
    VCR.use_cassette('subscription/error_no_email') do
      click_on 'Subscribe'
      page.should have_content('Error')
    end
  end
end
