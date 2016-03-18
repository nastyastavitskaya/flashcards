class ReviewsController < ApplicationController
  after_action { flash.discard if request.xhr? }

  def index
    @card = current_user.pending_cards.first
    respond_to do |format|
      format.html
      format.json {
        render json:
        {
          card_id: @card.id,
          original_text: @card.original_text,
          image: @card.image_url
        }
      }
    end
  end


  def create
    @card = current_user.cards.find(review_params[:card_id])
    user_answer = review_params[:user_translated_text]
    result = @card.check_translation(user_answer, review_params[:quality_timer])
    set_flash_message(user_answer, result)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: result }
    end
  end

  private

  def review_params
    params.require(:review).permit(:card_id, :user_translated_text, :quality_timer)
  end

  def set_flash_message(user_answer, result)
    case result
    when :correct
      flash[:success] = t("card.controller.review_success",
                          card: @card.translated_text,
                          review_params: review_params[:user_translated_text],
                          review_date: @card.review_date.strftime("%m/%d/%Y"))
    when :typo
      flash[:warning] = t("card.controller.review_typo",
                          card: @card.translated_text,
                          review_params: review_params[:user_translated_text])
    else
      flash[:danger] = t("card.controller.review_fail",
                          card: @card.translated_text,
                          review_params: review_params[:user_translated_text],
                          review_date: @card.review_date.strftime("%m/%d/%Y"))
    end
  end
end
