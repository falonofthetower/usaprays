require 'spec_helper'

describe JusticeSelector do
  describe ".for_day" do
    it 'returns the first four for last day of month' do
      9.times do |n|
        FactoryGirl.create(:justice, position: n)
      end

      justices = JusticeSelector.for_day("XX", '31-12-2017'.to_date)
      expect(justices.map(&:position)).to eq([0,1,2,3])
    end

    it 'returns the last five for the penultimate day of month' do
      9.times do |n|
        FactoryGirl.create(:justice, position: n)
      end

      justices = JusticeSelector.for_day("XX", '30-12-2017'.to_date)
      expect(justices.map(&:position)).to eq([4,5,6,7,8])
    end
  end
end
