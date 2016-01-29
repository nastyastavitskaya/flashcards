FactoryGirl.define do

  factory :authentication do
    user
    provider "facebook"
    uid 1234567890
  end


  factory :user do
    name "steve jobs"
    email "steve@apple.com"
    password "applebeforeapple"
    password_confirmation "applebeforeapple"
    current_category_id 1
    locale "en"
  end
end