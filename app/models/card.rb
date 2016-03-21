class Card < ActiveRecord::Base
  validates :original_text,
            :translated_text, presence: true

  validate :same_texts

  before_create :set_default_review_date

  belongs_to :category

  mount_uploader :image, ImageUploader

  scope :to_review, -> { where("review_date <= ?", DateTime.current).order("RANDOM()") }

  def self.create_with_category(params)
    category_params = params.delete(:category)
    if params[:category_id].blank?
      @category = Category.create(category_params)
      params.deep_merge!(category_id: @category.id)
    end
    create(params)
  end

  def check_translation(result, quality_timer)
    supermemo = SuperMemo2.new(efactor, repetition, interval, quality_timer, translated_text, result)
    update_attributes(supermemo.repetition_session)
    supermemo.result
  end

  private

  def set_default_review_date
    self.review_date = DateTime.current
  end

  def same_texts
    if sanitize_word(original_text) == sanitize_word(translated_text)
      errors.add(:translated_text, I18n.t('card.error'))
    end
  end

  def sanitize_word(string)
    string.mb_chars.downcase
  end
end