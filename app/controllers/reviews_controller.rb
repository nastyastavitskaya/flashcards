class ReviewsController < ApplicationController
  before_action :require_login

  def index
    @card = current_user.pending_cards.first
  end


  def create
    @card = current_user.cards.find(review_params[:card_id])
    @result = @card.check_translation(review_params[:user_translated_text])
    if @result == :correct
      flash[:success] = "Да!"
                        " Правильный ответ: #{@card.translated_text}, твой перевод: #{review_params[:user_translated_text]}."\
                        " Дата следующей проверки: #{@card.review_date.strftime('%b %-d, %Y %H:%M')}"

    elsif @result == :typo
      flash[:warning] = "Будь внимательнее!"\
                        " Правильный ответ: #{@card.translated_text}, твой перевод: #{review_params[:user_translated_text]}."\
    else
      flash[:danger] =  "Нет!"
                        " Правильный ответ: #{@card.translated_text}, твой перевод: #{review_params[:user_translated_text]}."\
                        " Дата следующей проверки: #{@card.review_date.strftime('%b %-d, %Y %H:%M')}"
    end
    redirect_to reviews_path
  end

  def review_params
    params.require(:review).permit(:card_id, :user_translated_text)
  end

  private

  def not_authenticated
    flash[:danger] = "Please log in first!"
    redirect_to log_in_path
  end
end
