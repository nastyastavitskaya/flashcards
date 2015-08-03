FactoryGirl.define do
  factory :card do
    user_id 1
    original_text "Hund"
    translated_text "Dog"
    review_date Date.today + 3.days
  end
end