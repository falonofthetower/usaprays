require 'spec_helper'

describe DonationLink do
  it "Returns default donation url" do
    DonationLink.url.should == "https://www.egsnetwork.com/gift2?giftid=40CA3B1B00824E7"
  end

  it "Returns donation url" do
    DonationLink.url('al').should == "https://www.egsnetwork.com/gift2?giftid=BD5EE61FBBF9449"
  end
end
