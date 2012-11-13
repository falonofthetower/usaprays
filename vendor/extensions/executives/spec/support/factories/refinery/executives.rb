
FactoryGirl.define do
  factory :executive, :class => Refinery::Executives::Executive do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

