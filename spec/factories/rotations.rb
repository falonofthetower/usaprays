# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rotation do
    name "MyString"
    pointer 1
    rate 1
    last_updated_on "2012-10-10"
  end
end
