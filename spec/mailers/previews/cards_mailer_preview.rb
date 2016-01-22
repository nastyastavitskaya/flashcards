# Preview all emails at http://localhost:3000/rails/mailers/cards_mailer
class CardsMailerPreview < ActionMailer::Preview
  def pending_cards_notification
    CardsMailer.pending_cards_notification(User.last)
  end
end
