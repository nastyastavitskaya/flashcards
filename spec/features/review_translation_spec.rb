require 'rails_helper'

feature "User card to review" do
  let(:card) { create(:card) }
  before(:each) do
    visit root_path
    click_link "Перейти к тренировщику"
    visit reviews_path
  end


 context "new cards to review" do
  it "input right translation" do
    if has_field?("user_translated_text")
      fill_in "user_translated_text", with: "dog"
      click_button "Проверить"
      expect(page).to have_content "Правильно!"
    end
  end

  it "input wrong translation" do
    if has_field?("user_translated_text")
      fill_in "user_translated_text", with: "doggg"
      click_button "Проверить"
      expect(page).to have_content "Не правильно!"
    end
  end
 end

 context "no cards to review" do
  it "displays no cards" do
    expect(page).to have_content("Новых карточек для проверки нет!")
  end
end

end