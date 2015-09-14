require 'rails_helper'

describe "Cards to review" do
  context "no cards to review" do
    before(:each) do
      user = create(:user)
      card = create(:card)
      visit log_in_path
      fill_in "Email", with: "steve@apple.com"
      fill_in "Password", with: "applebeforeapple"
      click_button "Log in"
      Timecop.freeze(Date.today - 5.days)
      visit root_path
      click_link "Перейти к тренировщику"
      visit reviews_path
    end

    it "no new cards to review" do
      expect(page).to have_content "Новых карточек для проверки нет"
     end
  end


  context "new cards to review" do
    before(:each) do
      user = create(:user)
      card = create(:card)
      visit log_in_path
      fill_in "Email", with: "steve@apple.com"
      fill_in "Password", with: "applebeforeapple"
      click_button "Log in"
      Timecop.freeze(Date.today + 5.days)
      visit root_path
      click_link "Перейти к тренировщику"
      visit reviews_path
    end

    it "input right translation" do
      fill_in "Введите перевод:", with: "Dog"
      click_button "Проверить"
      expect(page).to have_content "Правильно!"
    end

    it "input wrong translation" do
      fill_in "Введите перевод:", with: "doggg"
      click_button "Проверить"
      expect(page).to have_content "Не правильно!"
    end
  end
end
