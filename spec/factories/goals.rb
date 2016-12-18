FactoryGirl.define do
  factory :goal do
    year { Date.today.year }
    target 24
    user
  end
end
