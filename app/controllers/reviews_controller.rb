class ReviewsController < ApplicationController

  def index
    @card = current_user.pending_cards.first
  end


  def create
    @card = current_user.cards.find(review_params[:card_id])
    @result = @card.check_translation(review_params[:user_translated_text])
    if @result == :correct
      flash[:success] = t('card.controller.review_success', card: @card.translated_text, review_params: review_params[:user_translated_text], review_date: @card.review_date.strftime('%m/%d/%Y'))

    elsif @result == :typo
      flash[:warning] = t('card.controller.review_typo', card: @card.translated_text, review_params: review_params[:user_translated_text])

    else
      flash[:danger] = t('card.controller.review_fail', card: @card.translated_text, review_params: review_params[:user_translated_text], review_date: @card.review_date.strftime('%m/%d/%Y'))
    end
    redirect_to reviews_path
  end

  def review_params
    params.require(:review).permit(:card_id, :user_translated_text)
  end
end
