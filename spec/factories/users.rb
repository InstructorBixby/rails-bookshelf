FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "reader#{n}@example.com" }
    name 'A Reader'
    password 'swordfish'
  end
end
