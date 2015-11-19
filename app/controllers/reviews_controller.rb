class ReviewsController < ApplicationController
  before_action :require_login

  def index
    @card = current_user.pending_cards.first
  end


  def create
    @card = Card.find(review_params[:card_id])
    if @card.check_translation(review_params[:user_translated_text])
      flash[:success] = "Правильно!"
    else
      flash[:danger] = "Неправильно!"
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
