require 'spec_helper'

describe "States page", :skip => false do
  it "presents a home page" do
    ImportRecord.create
    create_admin_user
    visit "/"
    page.should have_content('Find Your State')
  end

  context "Consistantly keeps track of current leaders while" do
    let :todays_path do
      "/states/tx"
    end

    let :tomorrows_path do
      "/states/tx/#{Date.tomorrow.year}/#{Date.tomorrow.month}/#{Date.tomorrow.day}"
    end

    it "shows future leaders" do
      ImportRecord.create
      create_admin_user
      visit tomorrows_path
      tomorrows_leader = find(".leader-name").text
      visit todays_path
      find(".leader-name").text.should_not == tomorrows_leader
    end
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
      visit jan_2_url
      page.should have_content("Representative")
    end

    it "shows senator for state" do
      visit jan_2_url
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

  context "RSS" do
    it "shows rss view" do
      get "/states/in", :format => "rss"
      response.should be_success
      response.should render_template("states/show")
      response.content_type.should eq("application/rss+xml")
    end
  end

  context "Email test" do
    it "shows a view of what it might look like in email" do
      visit "/states/in/email"
      page.should have_content("Email Test")
    end
  end

  context "Cookies between controllers" do
    it "should remember state via cookies" do
      visit "/states/ca"
      visit "/leaders/us-rep-tx-louie-gohmert"
      click_on("State Home")
      current_path.should == "/states/tx"
    end
  end

end
