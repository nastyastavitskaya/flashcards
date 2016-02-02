require 'rails_helper'

describe 'user views home page' do
    before(:each) do
      @user1 = create(:user)
      visit log_in_path
      fill_in :email, with: 'steve@apple.com'
      fill_in :password, with: 'applebeforeapple'
      click_button I18n.t('header.login')
      visit root_path
    end


  context 'when the user has set locale to RU' do
    it 'displays right translation in russian' do
      visit edit_user_path(@user1)
      @user1.update(locale: :ru)
      visit root_path
      expect(page).to have_content('Первый в мире удобный менеджер флеш-карточек. Именно так.')
    end
  end

  context 'when the user has set locale to EN' do
    it 'displays right translation in english' do
      visit edit_user_path(@user1)
      @user1.update(locale: :en)
      visit root_path
      expect(page).to have_content('First ever flashcards application that is easy to use.')
    end
  end
end
