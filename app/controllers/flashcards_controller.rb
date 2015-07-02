class FlashcardsController < ApplicationController
  
 def index
   @card = Card.to_review.first
  end
end
