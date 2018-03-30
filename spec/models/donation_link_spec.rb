require 'spec_helper'

describe DonationLink do
  it "Returns default donation url" do
    DonationLink.url.should == "https://www.myegiving.com/dl/?uid=eGiving-147102"
  end

  it "Returns donation url" do
    DonationLink.url('al').should == "https://www.myegiving.com/dl/?uid=eGiving-147102"
  end
end
