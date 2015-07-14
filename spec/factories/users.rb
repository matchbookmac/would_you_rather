FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    admin false
    email { "#{username}@user.com" }
    sequence(:password, 10000000) { |n| "#{n}" }

    trait :admin do
      admin true
      email { "#{username}admin@user.com" }
      sequence(:password, 10000000) { |n| "#{n}admin" }
    end

    trait :logged_in do
      after(:create) { |user| login_as user, scope: :user }
    end

    trait :with_questions do
      transient do
        questions_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:question, evaluator.questions_count, user: user)
      end
    end

    factory :admin, traits: [:admin]

    factory :logged_in_admin, traits: [:logged_in, :admin]

    factory :logged_in_user, traits: [:logged_in]

    factory :user_with_questions, traits: [:with_questions]

    factory :logged_in_user_with_questions, traits: [:logged_in, :with_questions]
  end

end
