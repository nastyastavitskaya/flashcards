FactoryGirl.define do
  factory :card do
    original_text "Hund"
    translated_text "Dog"
    review_date Date.today + 3.days
  end
end