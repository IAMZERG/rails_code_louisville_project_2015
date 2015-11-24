FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    email "user1@odot.com"
    password "treehouse1"
    password_confirmation "treehouse1"
  end
end
