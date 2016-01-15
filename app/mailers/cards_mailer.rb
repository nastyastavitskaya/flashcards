class CardsMailer < ApplicationMailer
  def pending_cards_notification(user)
    @user = user
    @card = @user.pending_cards
    mail(to: @user.email, subject: "Карточки для проверки!")
  end
end
