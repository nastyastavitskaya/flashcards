class ReviewsController < ApplicationController
  def index
    @card = Card.to_review.first
  end

  def create
    @card = Card.find(review_params[:card_id])
    if @card.check_translation(review_params[:user_translated_text])
      flash[:notice] = "Правильно!"
    else
      flash[:alert] = "Не правильно!"
    end
    redirect_to root_path
  end

  def review_params
    params.require(:review).permit(:card_id, :user_translated_text)
  end
end