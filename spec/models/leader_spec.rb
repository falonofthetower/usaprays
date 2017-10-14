require 'spec_helper'

describe Leader do
  describe '#birthday' do
    let(:leader) { FactoryGirl.build(:leader, birthmonth: "12", birthdate: "12", birthyear: "1985")}

    it "strings them together" do
      expect(leader.birthday).to eq("12-12-1985")
    end
  end

  describe "#shortname" do
    context "with a sufficiently short name" do
      let(:leader) {
        FactoryGirl
          .build(
            :leader,
            firstname: "Foo",
            lastname: "Bar",
            legalname: "Foo Baz Bar"
        )
      }

      it "returns the full name" do
        expect(leader.shortname).to eq("Foo Baz Bar")
      end
    end

    context "with an extra long firstname" do
      let(:leader) {
        FactoryGirl
          .build(
            :leader,
            firstname: "Supercalifragilisticexpialidocious",
            lastname: "Bar",
            legalname: "Supercalifragilisticexpialidocious Bar"
        )
      }

      it "returns truncated first name" do
        expect(leader.shortname).to eq("S. Bar")
      end
    end

    context "with an extra long lastname" do
      let(:leader) {
        FactoryGirl
          .build(
            :leader,
            firstname: "Foo",
            lastname: "Supercalifragilisticexpialidocious",
            legalname: "Foo Baz Supercalifragilisticexpialidocious"
        )
      }

      it "returns truncated lastname" do
        expect(leader.shortname).to eq("Foo S.")
      end
    end
  end
end
