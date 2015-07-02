class FlashcardsController < ApplicationController
  
 def index
   @card = Card.review_time.first
  end
end
