FactoryGirl.define do
  factory :option do
    sequence(:query) { |n| "#{n}asdf" }
    question

    factory :option_with_votes do

      transient do
        votes_count 3
      end

      after(:create) do |option, evaluator|
        create_list(:vote, evaluator.votes_count, votable: option)
      end
    end

  end
end
