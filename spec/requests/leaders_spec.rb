require 'spec_helper'

describe "State Leaders page" do
  before do
    visit "/states/in/leaders"
  end

  skip "shows a particular state" do
    page.should have_content("Indiana")
  end

  skip "lists all leaders for a state" do
    page.should have_selector('.thumbnail-leader')
  end

  skip "links each leader to individual leader page" do
    find("a.thumbnail").click
    page.should have_selector(".leader-name")
  end
end
