FactoryGirl.define do
  factory :option do
    sequence(:query) { |n| "#{n}asdf" }
  end
end
