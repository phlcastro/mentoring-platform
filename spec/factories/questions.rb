FactoryGirl.define do
  factory :question do
    association :from_user, factory: :user
    association :to_user, factory: :user
    description 'fake question?'
  end
end
