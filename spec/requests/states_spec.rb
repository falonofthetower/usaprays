require 'spec_helper'

describe "States page", :skip => false do

  it "presents a home page" do
    visit "/"
    page.should have_content('Find Your State')
  end

  context "Indiana" do 
    before do
      visit "/states/in/2012/01/01"
    end

    it "shows a unique date, each day" do
      visit "/states/in/2012/01/01"
      date = find(".date").text
      visit "/states/in/2012/01/02"
      date.should_not == find(".date").text
    end

    it "shows a different leader on different days" do
      visit "/states/in/2012/01/01"
      name = find(".leader-name").text
      visit "/states/in/2012/01/02"
      name.should_not == find(".leader-name").text
    end


    it "shows specific state" do
      page.should have_content("Indiana")
    end

    it "shows representative for state" do
      page.should have_content("Representative")
    end

    it "shows senator for state" do
      page.should have_content("Senator")
    end

    it "includes image of member" do
      page.should have_selector('img.head-shot')
    end

    it "has navigation to all leaders for a state" do
      VCR.use_cassette "states_page/all_leaders" do
        click_on("Leaders")
        current_path.should == "/states/in/leaders"
      end
    end
  end

  context "nebraska" do
    before do
      VCR.use_cassette "states_page/ne" do
        visit "/states/ne"
      end
    end

    it "shows specific state" do
      page.should have_content("Nebraska")
    end

    it "shows a unique date, each day" do
      VCR.use_cassette "states_page/ne_each_day" do
        date = find(".date").text
        time_travel_to(Date.tomorrow) do
          visit "/states/ne"
          date.should_not == find(".date").text
        end
      end
    end

    context "Rotation" do
      it "shows a different leader on different days" do
        VCR.use_cassette "states_page/ne_different_days" do
          name = find(".leader-name").text
          time_travel_to(Date.tomorrow) do
            visit "/states/ne"
            name.should_not == find(".leader-name").text
          end
        end
      end
    end
  end
end
