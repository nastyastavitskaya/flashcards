class FlashcardsController < ApplicationController
  
 def index
   #@card = Card.where(review_date: Date.today)
   @card = Card.review_time.first
  end
end
