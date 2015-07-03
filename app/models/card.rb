class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validate :same_texts
  before_save :set_default_review_date, on: :create
  scope :to_review, -> { where("review_date <= ?", Date.today).order('RANDOM()') }
  
  
  def same_texts
    if original_text.downcase == translated_text.downcase
      errors.add(:original_text, "and #{:translated_text} can't be same!")
    end
  end

  def set_default_review_date
    self.review_date = Time.now + 3.days
  end

  def check_translation(user_translated_text)
    translated_text.mb_chars.downcase.to_s == user_translated_text.mb_chars.downcase.to_s

  end
  
  def update_review_date
    update_attribute(:review_date, self.review_date + 3.days)
  end
  
  
  def downcase
    String.mb_chars.downcase
  end
end

