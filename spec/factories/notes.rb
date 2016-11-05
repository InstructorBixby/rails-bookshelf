FactoryGirl.define do
  factory :note do
    body 'A thing worth remembering.'
    page 42
    book
  end
end
