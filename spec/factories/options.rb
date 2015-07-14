FactoryGirl.define do
  factory :option do
    sequence(:query) { |n| "#{n}asdf" }
    question
  end
end
