FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    author 'A Writer'
    pages 300
  end
end
