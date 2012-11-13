# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Executives" do
    describe "Admin" do
      describe "executives" do
        login_refinery_user

        describe "executives list" do
          before do
            FactoryGirl.create(:executive, :name => "UniqueTitleOne")
            FactoryGirl.create(:executive, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.executives_admin_executives_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.executives_admin_executives_path

            click_link "Add New Executive"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Executives::Executive.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Executives::Executive.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:executive, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.executives_admin_executives_path

              click_link "Add New Executive"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Executives::Executive.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:executive, :name => "A name") }

          it "should succeed" do
            visit refinery.executives_admin_executives_path

            within ".actions" do
              click_link "Edit this executive"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:executive, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.executives_admin_executives_path

            click_link "Remove this executive forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Executives::Executive.count.should == 0
          end
        end

      end
    end
  end
end
