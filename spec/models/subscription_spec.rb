require 'spec_helper'

describe Subscription do

  let :subscription do
    Subscription.new(
      name: "bob", 
      email: "bob@bobmail.com",
      state_code: "tx",
      cycle: "daily")
  end

  context "#save" do
    it "saves form info to mail chimp list" do
      VCR.use_cassette "subscription/saves_form_info" do
        subscription.save.should be_true
      end
    end

    it "does not save if email missing" do
      VCR.use_cassette "subscription/email_missing" do
        subscription.email = ""
        subscription.save.should be_false
      end
    end

    it "does not save if email invalid" do
      VCR.use_cassette "subscription/email_invalid" do
        subscription.email = "not an email"
        subscription.save.should be_false
      end
    end
  end
end
