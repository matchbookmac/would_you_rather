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

    trait :logged_in do
      after(:create) { |user| login_as user, scope: :user }
    end

    factory :admin, traits: [:admin]

    factory :logged_in_admin, traits: [:logged_in, :admin]

    factory :logged_in_user, traits: [:logged_in]
  end

end
