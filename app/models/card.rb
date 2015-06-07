class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :same_texts
  before_save :add_days, on: :create
  scope :check_review_date, -> { where("review_date <=?", Date.today) }
  
  def same_texts
    if original_text.mb_chars.downcase.to_s == translated_text.mb_chars.downcase.to_s
      errors.add(:original_text, "and #{:translated_text} can't be same!")
    end
  end

  def add_days
    self.review_date = review_date + 3.days
  end

end
