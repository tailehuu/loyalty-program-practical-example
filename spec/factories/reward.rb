FactoryGirl.define do
  factory :reward do
    name { Faker::Name.unique.name }
  end
end
