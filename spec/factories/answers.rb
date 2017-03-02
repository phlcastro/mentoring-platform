FactoryGirl.define do
  factory :answer do
    association :question, factory: :question
    sequence(:description) { |n| "Answer #{n}" }
  end
end
