FactoryGirl.define do
  factory :question do
    user
    
    transient do
      options_count 2
    end

    after(:create) do |question, evaluator|
      create_list(:option, evaluator.options_count, question: question)
    end
  end
end
