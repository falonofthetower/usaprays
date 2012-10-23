require 'spec_helper'

describe MailChimp do

  let :mc do
    MailChimp.new
  end

  it 'knows mailing list id' do
    VCR.use_cassette "mail_chimp/list_id" do
      mc.list_id.should be
    end
  end

  it 'can get a list of segments' do
    VCR.use_cassette "mail_chimp/list_segments" do
      mc.segments.should be
    end
  end

  it 'can get a list of members' do
    VCR.use_cassette "mail_chimp/list_members" do
      mc.members.should be
    end
  end

  it 'can subscribe a member' do
    VCR.use_cassette "mail_chimp/subscribe_member" do
      mc.subscribe("test.email@gmail.com", "NAME" => "bob").should be_true
    end
  end

  it 'can create segment' do
    VCR.use_cassette "mail_chimp/create_segment" do
      mc.delete_segment('segment-name')
      mc.create_segment('segment-name')
      mc.segments.collect{|s|s['name']}.include?('segment-name').should be_true
    end
  end

  it 'can delete segment' do
    VCR.use_cassette "mail_chimp/delete_segment" do
      mc.create_segment('segment-name')
      mc.delete_segment('segment-name')
      mc.segments.collect{|s|s['name']}.include?('segment-name').should be_false
    end
  end

  it 'can subscribe email list and segment' do
    VCR.use_cassette "mail_chimp/subscribe_to_segment" do
      mc.create_segment('segment-name')
      mc.subscribe_to_segment('test.email@gmail.com', 'segment-name', 'NAME' => 'test person')["success"].should == 1
    end
  end

end
