class ReviewsController < ApplicationController
  def create
    @card = Card.find(review_params[:id])
    if @card.check_translation(review_params[:user_translated_text])
      flash[:notice] = "Правильно!"
    else
      flash[:alert] = "Не правильно!"
    end
    redirect_to root_path
  end

  def review_params
    params.require(:review).permit(:id, :user_translated_text)
  end
end