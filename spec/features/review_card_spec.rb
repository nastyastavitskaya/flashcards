require 'rails_helper'

describe "Cards to review" do
  before(:each) do
    @user = create(:user)
    visit log_in_path
    fill_in "Email", with: "steve@apple.com"
    fill_in "Password", with: "applebeforeapple"
    click_button "Log in"
    visit root_path
  end

  context "#no category" do
    it "nothing to review" do
      click_link "Перейти к тренировщику"
      visit reviews_path
      expect(page).to have_content "Новых карточек для проверки нет"
    end
  end


  context "#new cards to review" do
    before(:each) do
      click_link "New Category"
      @category = create(:category, user_id: @user.id)
      card = FactoryGirl.create(:card, user_id: @user.id, category_id: @category.id)
      visit root_path
      click_link "Перейти к тренировщику"
      visit reviews_path
    end

    it "input wrong translation" do
      fill_in "Введите перевод:", with: "doggg"
      click_button "Проверить"
      expect(page).to have_content "Не правильно!"
    end

    it "input right translation" do
      fill_in "Введите перевод:", with: "Dog"
      click_button "Проверить"
      expect(page).to have_content "Правильно!"
    end
  end

  context "#user's category to review" do
    before(:each) do
      click_link "New Category"
      @category = create(:category, user_id: @user.id)
      card = create(:card, user_id: @user.id, category_id: @category.id)
      visit root_path
      click_link "Перейти к тренировщику"
    end

    it "when card belongs to user" do
      expect(page).to have_content(@card)
    end

    it "when card not belongs to user" do
      @user = User.create(name: "lollipop", email: "lol@mail.com",
        password: "1234", password_confirmation: "1234")
      visit log_in_path
      fill_in "Email", with: "lol@mail.com"
      fill_in "Password", with: "1234"
      click_button "Log in"
      visit root_path
      click_link "Перейти к тренировщику"
      expect(page).to have_content("Новых карточек для проверки нет")
    end
  end
end

