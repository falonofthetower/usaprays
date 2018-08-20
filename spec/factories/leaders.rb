FactoryGirl.define do
  factory :leader do
    lastname "Last Name"
    birthmonth "12"
    birthdate "12"
    birthyear "1975"
    import_timestamp 10.days.ago
  end
end
