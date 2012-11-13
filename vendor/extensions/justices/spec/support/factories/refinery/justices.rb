
FactoryGirl.define do
  factory :justice, :class => Refinery::Justices::Justice do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

