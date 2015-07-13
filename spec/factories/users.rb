FactoryGirl.define do
  factory :user do
    username "user"
    admin false
    sequence(:email) { |n| "#{n}@user.com" }
    sequence(:password, 10000000) { |n| "#{n}" }

    trait :admin do
      admin true
      sequence(:email) { |n| "admin#{n}@user.com" }
      sequence(:password, 10000000) { |n| "#{n}admin" }
    end

    factory :admin, traits: [:admin]
  end

end
