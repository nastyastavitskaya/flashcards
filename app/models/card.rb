class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true, uniqueness: true
  validate :sametexts
  
  def sametexts
    if self.original_text == self.translated_text
      errors.add(:Error!, "Original text and translation can't be same!")
    end
  end
end
