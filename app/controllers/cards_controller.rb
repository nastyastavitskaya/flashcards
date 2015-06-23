class CardsController < ApplicationController
  before_action :find_card, 
                only: [:show, :edit, :update, :destroy, :review]
  
  def index
    @cards = Card.all
  end


  def show
  end

  
  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    
    if @card.save
      redirect_to @card
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def review
    if @card.check_translation(params[:user_translated_text])
      flash[:notice] = "Правильно!"
      @card.update_review_date
    else
      flash[:alert] = "Не правильно!"
    end
    redirect_to root_path
  end



  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text, :review_date, :user_translated_text)
  end


  def find_card
    @card = Card.find(params[:id])
  end

end
