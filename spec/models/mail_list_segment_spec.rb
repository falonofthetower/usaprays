require 'spec_helper'

describe MailListSegment do
  skip "knows its name" do
    segment = MailListSegment.new(UsState.new('tx'), 'daily')
    segment.name.should == 'tx-daily'
  end

  skip "knows its public name" do
    segment = MailListSegment.new(UsState.new('tx'), 'daily')
    segment.public_name.should == 'Texas Daily Prayer List'
  end

  skip "creates itself on MailChimp" do
    VCR.use_cassette "mail_chimp_segment/creates_itself" do
      segment = MailListSegment.new(UsState.new('tx'), 'daily-test')
      segment.create
      segments = MailChimp.new.segments.collect{|s|s['name']}
      segments.include?('tx-daily-test').should be_true
    end
  end
end
