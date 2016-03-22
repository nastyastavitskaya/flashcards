class ReviewsController < ApplicationController

  def index
    @card = current_user.pending_cards.first
    respond_to do |format|
      if @card
        format.html
        format.json {
          render json:
          {
            card_id: @card.id,
            original_text: @card.original_text,
            image: @card.image_url
          }
        }
      else
        format.html
        format.json { render json: { message: t("card.review.no_cards") } }
      end
    end
  end

  def create
    @card = current_user.cards.find(review_params[:card_id])
    result = @card.check_translation(review_params[:user_translated_text], review_params[:quality_timer])
    respond_to do |format|
      if result == :correct
        format.html {
          redirect_to :back
          flash[:success] = t("card.controller.review_success",
          card: @card.translated_text,
          review_params: review_params[:user_translated_text],
          review_date: @card.review_date.strftime("%m/%d/%Y"))
        }
        format.json {
          render json:
          {
            message: t("card.controller.review_success",
            card: @card.translated_text,
            review_params: review_params[:user_translated_text],
            review_date: @card.review_date.strftime("%m/%d/%Y"))
          }
        }

      elsif result == :typo
        format.html {
          redirect_to :back
          flash[:notice] = t("card.controller.review_typo",
          card: @card.translated_text,
          review_params: review_params[:user_translated_text])
        }
        format.json {
          render json: {
            message: t("card.controller.review_typo",
            card: @card.translated_text,
            review_params: review_params[:user_translated_text])
          }
        }
      else
        format.html {
          redirect_to :back
          flash[:danger] = t("card.controller.review_fail",
          card: @card.translated_text,
          review_params: review_params[:user_translated_text],
          review_date: @card.review_date.strftime("%m/%d/%Y"))
        }
        format.json {
          render json: {
            message: t("card.controller.review_fail",
            card: @card.translated_text,
            review_params: review_params[:user_translated_text],
            review_date: @card.review_date.strftime("%m/%d/%Y"))
          }
        }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translated_text, :quality_timer)
  end
end
