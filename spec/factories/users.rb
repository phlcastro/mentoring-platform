FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password "Abcd4321"
    password_confirmation "Abcd4321"
  end
end
