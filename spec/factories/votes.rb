FactoryGirl.define do
  factory :vote do
    association :user, factory: :user
    votable 1
  end
end
