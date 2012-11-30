require 'spec_helper'

describe DonationLink do
  it "Returns default donation url" do
    DonationLink.url.should == "https://www.egsnetwork.com/gift/gift.php?giftid=EBBB84EB-568B-4F1E-BAED-69CFD18C7270"
  end

  it "Returns donation url" do 
    DonationLink.url('al').should == "https://www.egsnetwork.com/gift/gift.php?giftid=BD5EE61FBBF9449"
  end
end
