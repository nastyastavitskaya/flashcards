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

  def check_translation(user_translated_text, quality_timer)
    result = translation_distance(user_translated_text, translated_text)
    quality_timer = 0 if result == :wrong
    supermemo = SuperMemo2.new(interval, efactor, repetition, quality_timer)
    update_attributes(supermemo.repetition_session)
    if result == :typo
      decrement_quality_when_typo
    end
    result
  end

  def decrement_quality_when_typo
    decrement(:quality)
  end

  def translation_distance(user_translated_text, translated_text)
    distance = Levenshtein.distance(user_translated_text, translated_text)
    if distance == 0
      :correct
    elsif distance == 1 || distance == 2
      :typo
    else
      :wrong
    end
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