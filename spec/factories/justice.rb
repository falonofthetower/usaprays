FactoryGirl.define do
  factory :justice, :class => Refinery::Justices::Justice do
    name { Faker::Name.name }
    title { Faker::Name.title }
  end
end
