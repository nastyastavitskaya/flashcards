require 'rails_helper'

describe "Cards to review" do
  before(:each) do
    @user = create(:user, locale: "en")
    visit log_in_path
    fill_in :email, with: "steve@apple.com"
    fill_in :password, with: "applebeforeapple"
    click_button "Log In"
    visit root_path
  end

  context "#no cards" do
    before(:each) do
      click_link "New Card"
      @card = create(:card, review_date: DateTime.current - 7.days)
      visit root_path
      click_link "Trainig"
      visit reviews_path
    end

    it "no new cards to review" do
      expect(page).to have_content "No new card to review!"
    end
  end


  context "#new cards to review" do
    before(:each) do
      click_link "New Category"
      @category = create(:category, user_id: @user.id)
      @card = Card.create(
        original_text: "hund",
        translated_text: "dog",
        category_id: @category.id,
        review_date: DateTime.current - 7.days)
      visit root_path
      click_link "Trainig"
      visit reviews_path
    end

    it "input wrong translation" do
      fill_in "Your translation:", with: "cat"
      click_button "Check"
      expect(page).to have_content "No"
    end

    it "input typo" do
      fill_in "Your translation:", with: "dogg"
      click_button "Check"
      expect(page).to have_content "Watch out!"
    end

    it "input right translation" do
      fill_in "Your translation:", with: "dog"
      click_button "Check"
      expect(page).to have_content "Yes!"
    end
  end

  context "#user's category to review" do
    before(:each) do
      click_link "New Category"
      @category = create(:category, user_id: @user.id)
      card = create(:card, category_id: @category.id)
      visit root_path
      click_link "Trainig"
      visit reviews_path
    end

    it "when card belongs to user" do
      expect(page).to have_content(@card)
    end

    it "when card not belongs to user" do
      @user = User.create(name: "lollipop", email: "lol@mail.com",
        password: "1234", password_confirmation: "1234")
      visit log_in_path
      fill_in :email, with: "lol@mail.com"
      fill_in :password, with: "1234"
      click_button "Log In"
      visit root_path
      click_link "Trainig"
      expect(page).to have_content("No new card to review!")
    end
  end

  context "card from category" do
    before(:each) do
      @category_one = create(:category, name: "first", user_id: @user.id)
      @category_two = create(:category, name: "second", user_id: @user.id)
      @card_one = Card.create(
        original_text: "one",
        translated_text: "один",
        category_id: @category_one.id,
        review_date: DateTime.current - 17.days)
      @card_two = Card.create(
        original_text: "two",
        translated_text: "два",
        category_id: @category_two.id)
      visit categories_path
    end

    it "shows right card" do
      @user.update(current_category_id: @category_one.id)
      visit reviews_path
      expect(page).to have_content "one"
    end
  end
end

