require 'rails_helper'

feature "User card translation" do
  let(:card) { FactoryGirl.create(:card) }
  before(:each) do
    visit root_path
    click_link "Перейти к тренировщику"
  end


  scenario "with correct input" do
    visit reviews_path
    if has_field?("user_translated_text")
      fill_in "user_translated_text", with: "dog"
      click_button "Проверить"
      expect(page).to have_content "Правильно!"
    end
  end

  scenario "with incorrect input" do
    visit reviews_path
    if has_field?("user_translated_text")
      fill_in "user_translated_text", with: "doggg"
      click_button "Проверить"
      expect(page).to have_content "Не правильно!"
    end
  end

  scenario "with no input" do
    visit reviews_path
    if has_field?("user_translated_text")
      fill_in "user_translated_text", with: ""
      click_button "Проверить"
      expect(page).to redirect_to reviews_path
    end
  end

end