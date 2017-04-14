require 'spec_helper'

describe Slugifier do
  describe ".construct" do
    context "US House" do
      let(:title)
    end

    context "US Senate" do
    end

    context "State Senate" do
    end

    context "State House" do
    end
  end

  describe ".deconstruct" do
    context "US House" do
      let(:slug) { "us-rep-tx-brian-babin"}
      let(:response) { Slugifier.deconstruct(slug) }

      it "returns the correct chamber" do
        response[:chamber].should eq("US House")
      end
    end

    context "US Senate" do
      let(:slug) { "us-sen-tx-ted-cruz"}
      let(:response) { Slugifier.deconstruct(slug) }

      it "returns the correct house" do
        response[:chamber].should eq("US Senate")
      end
    end

    context "State Senate" do
      let(:slug) { "state-sen-tx-konni-burton"}
      let(:response) { Slugifier.deconstruct(slug) }

      it "returns the correct chamber" do
        response[:chamber].should eq("State Senate")
      end
    end

    context "State House" do
      let(:slug) { "state-rep-tx-alma-allen"}
      let(:response) { Slugifier.deconstruct(slug) }

      it "returns the correct house" do
        response[:chamber].should eq("State House")
      end
    end

    context "States" do
      let(:slug_tx) { "state-sen-tx-brian-babin"}
      let(:slug_ri) { "state-sen-ri-brian-babin"}
      let(:slug_mi) { "state-sen-mi-brian-babin"}
      let(:response_tx) { Slugifier.deconstruct(slug_tx) }
      let(:response_ri) { Slugifier.deconstruct(slug_ri) }
      let(:response_mi) { Slugifier.deconstruct(slug_mi) }

      it "handles multiple states" do
        response_tx[:state].should eq("tx")
        response_ri[:state].should eq("ri")
        response_mi[:state].should eq("mi")
      end
    end

    describe "matching slug" do
      context "slug exists" do
        # let(:slug) { "state-sen-tx-brian-birdwell"}
        # let(:response) { Slugifier.deconstruct(slug) }

        # it "returns the correct chamber" do
        #   response[:chamber].should eq("State Senate")
        # end

        let(:slug) { "state-sen-tx-konni-burton"}
        let(:response) { Slugifier.deconstruct(slug) }

        it "returns the know_who_id if" do
          response[:know_who_id].should eq("482956")
        end
      end

      context "slug does not exist" do
        let(:slug) { "state-sen-tx-brian-birdwell"}
        let(:response) { Slugifier.deconstruct(slug) }

        it "creates the slug and returns it" do
        end
      end
    end
  end
end
