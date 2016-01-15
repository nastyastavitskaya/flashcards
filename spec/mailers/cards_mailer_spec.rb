require "rails_helper"

describe "Cards Mailer" do
  describe 'pending_cards_notification' do
    let(:user) { create(:user) }
    let(:mail) { CardsMailer.pending_cards_notification(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq("Карточки для проверки!")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end
  end
end
