FactoryGirl.define do
  factory :question do
    association :from_user, factory: :user
    association :to_user, factory: :user
    sequence(:description) { |n| "Question #{n}?" }
  end
end
