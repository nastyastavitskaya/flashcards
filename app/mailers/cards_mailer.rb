class CardsMailer < ApplicationMailer
  def pending_cards_notification(user)
    @user = user
    @card = @user.pending_cards
    mail(to: @user.email, subject: t('card.mailer.subject'))
  end
end
