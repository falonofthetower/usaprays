# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Justices" do
    describe "Admin" do
      describe "justices" do
        login_refinery_user

        describe "justices list" do
          before do
            FactoryGirl.create(:justice, :name => "UniqueTitleOne")
            FactoryGirl.create(:justice, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.justices_admin_justices_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.justices_admin_justices_path

            click_link "Add New Justice"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Justices::Justice.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Justices::Justice.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:justice, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.justices_admin_justices_path

              click_link "Add New Justice"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Justices::Justice.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:justice, :name => "A name") }

          it "should succeed" do
            visit refinery.justices_admin_justices_path

            within ".actions" do
              click_link "Edit this justice"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:justice, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.justices_admin_justices_path

            click_link "Remove this justice forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Justices::Justice.count.should == 0
          end
        end

      end
    end
  end
end
