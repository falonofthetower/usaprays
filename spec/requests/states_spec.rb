require 'spec_helper'

describe "States page", :skip => false do

  it "presents a home page" do
    visit "/"
    page.should have_content('Find Your State')
  end

  context "Indiana" do 
    let :jan_1_url do 
      "/states/in/2012/01/01"
    end

    let :jan_2_url do
      "/states/in/2012/01/02"
    end

    it "shows a unique date, each day" do
      visit jan_1_url
      date = find(".date").text
      visit jan_2_url
      date.should_not == find(".date").text
    end

    it "shows a different leader on different days" do
      visit jan_1_url
      name = find(".leader-name").text
      visit jan_2_url
      name.should_not == find(".leader-name").text
    end

    it "shows specific state" do
      visit jan_1_url
      page.should have_content("Indiana")
    end

    it "shows representative for state" do
      visit jan_1_url
      page.should have_content("Representative")
    end

    it "shows senator for state" do
      visit jan_1_url
      page.should have_content("Senator")
    end

    it "includes image of member" do
      visit jan_1_url
      page.should have_selector('img.head-shot')
    end

    it "has navigation to all leaders for a state" do
      visit jan_1_url
      click_on("Leaders")
      current_path.should == "/states/in/leaders"
    end
  end

end
