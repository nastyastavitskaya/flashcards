class CardsController < ApplicationController
  before_action :find_category, except: [:new, :create ]

  def index
  end

  def new
    @category = current_user.categories.new
    @card = current_user.cards.new
  end

  def create
    @category = current_user.categories.new(card_params[:category])
    @card = @category.cards.new(card_params.except(:category))
    if @card.save
      flash[:success] = "Added card."
      redirect_to categories_path
    else
      flash[:danger] = "There was a problem adding that card."
      render 'new'
    end
  end

  def show
    @card = @category.cards.find(params[:id])
  end

  def edit
    @card = @category.cards.find(params[:id])
  end

  def update
     @card = @category.cards.find(params[:id])
    if @card.update_attributes(card_params.except(:category))
      flash[:success] = "Saved card."
      redirect_to category_cards_path
    else
      flash[:error] = "That card could not be saved."
      render 'edit'
    end
  end

  def destroy
    @card = @category.cards.find(params[:id])
    @card.destroy
    flash[:danger] = "Card deleted."
    redirect_to category_cards_path
  end

  private

  def find_category
    @category = current_user.categories.find(params[:category_id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :category_id, category: [:name])
  end

end
