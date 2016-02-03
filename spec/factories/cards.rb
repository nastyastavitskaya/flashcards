FactoryGirl.define do
  factory :card do
    category_id 1
    original_text "hund"
    translated_text "dog"
    review_date DateTime.current
  end
end