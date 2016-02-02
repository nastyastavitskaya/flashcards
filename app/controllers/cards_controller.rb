class CardsController < ApplicationController
  before_action :find_category, except: [:new, :create]
  before_action :find_card, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @category = current_user.categories.new
    @card = current_user.cards.new
  end

  def create
    @card = Card.create_with_category(card_params)
    if @card.errors.empty?
      flash[:success] = t('card.controller.create_success')
      redirect_to categories_path
    else
      flash[:danger] = t('card.controller.create_fail')
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @card.update_attributes(card_params.except(:category))
      flash[:success] = t('card.controller.update_success')
      redirect_to category_cards_path
    else
      flash[:error] = t('card.controller.update_fail')
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    flash[:danger] = t('card.controller.destroy')
    redirect_to category_cards_path
  end

  private

  def find_category
    @category = current_user.categories.find(params[:category_id])
  end

  def find_card
    @card = @category.cards.find(params[:id])
  end


  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :category_id, category: [:name]).deep_merge(category: {user_id: current_user.id})
  end
end
