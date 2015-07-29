require 'rails_helper'

describe "Cards to review" do
  context "no cards to review" do
    before(:each) do
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
      card = create(:card)
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
