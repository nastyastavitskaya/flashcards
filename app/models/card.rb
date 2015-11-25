class Card < ActiveRecord::Base
  validates :original_text,
            :translated_text, presence: true

  validate :same_texts

  before_save :set_default_review_date, on: :create

  belongs_to :category

  mount_uploader :image, ImageUploader

  scope :to_review, -> { where("review_date <= ?", Date.today).order('RANDOM()') }

  def set_default_review_date
    self.review_date = Time.now + 3.days
  end

  def check_translation(user_translated_text)
    if sanitize_word(translated_text) == sanitize_word(user_translated_text)
      update_review_date
    end
  end

  def update_review_date
    update_attribute(:review_date, self.review_date + 3.days)
  end

  def self.create_with_category(params)
    category_params = params.delete(:category)
    if params[:category_id].blank?
      @category = Category.create(category_params)
      params.deep_merge!(category_id: @category.id)
    end
    create(params)
  end

  private

  def same_texts
    if sanitize_word(original_text) == sanitize_word(translated_text)
      errors.add(:original_text, "and #{:translated_text} can't be same!")
    end
  end

  def sanitize_word(string)
    string.mb_chars.downcase
  end
end