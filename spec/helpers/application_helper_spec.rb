require 'spec_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#fastly_url' do
    it 'returns the url supplied when it already has a fastly root' do
      url_with_fastly_root = "bob-pray1tim2-herokuapp-com.global.ssl.fastly.net/foo_bar"
      result = helper.fastly_url(url_with_fastly_root)
      expect(result).to eq url_with_fastly_root
    end

    it 'returns the url with a fastly root when supplied one with a non-fastly root' do
      url_with_fastly_root = "bob-pray1tim2-herokuapp-com.global.ssl.fastly.net/foo_bar"
      url_with_non_fastly_root = "#{ENV['HTTP_HOST']}/foo_bar"

      result = helper.fastly_url(url_with_non_fastly_root)
      expect(result).to eq url_with_fastly_root
    end
  end
end
