FactoryGirl.define do
  factory :user do
    sequence(:name) { Faker::Name.name }
  end
end
