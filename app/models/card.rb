class Card < ActiveRecord::Base
  validates :original_text,
            :translated_text, presence: true


  validate :same_texts

  before_save :set_default_review_date, on: :create

  belongs_to :category

  mount_uploader :image, ImageUploader

  scope :to_review, -> { where("review_date <= ?", Date.today).order('RANDOM()') }

  def self.create_with_category(params)
    category_params = params.delete(:category)
    if params[:category_id].blank?
      @category = Category.create(category_params)
      params.deep_merge!(category_id: @category.id)
    end
    create(params)
  end


  def check_translation(user_translated_text)
    # if sanitize_word(translated_text) == sanitize_word(user_translated_text)

    case Levenshtein.distance(user_translated_text, translated_text)
    when 0
      correct_answers
      @result = :true
    when 1, 2
      @result = :typo
    else
      incorrect_answers
      @result = :false
     end
  end

  def correct_answers
    update_attributes(num_of_incorrect_answers: 0)
    increment(:num_of_correct_answers) if num_of_correct_answers < 5
    update_review_date
  end

  def incorrect_answers
    decrement(:num_of_correct_answers) if num_of_correct_answers > 0
    increment(:num_of_incorrect_answers) if num_of_incorrect_answers < 3
    update_review_date
  end

  def update_review_date
    num_of_review =  case num_of_correct_answers
      when 0
        0
      when 1
        12.hour
      when 2
        3.day
      when 3
        7.day
      when 4
        14.day
      else
        1.month
      end
    update_attributes(review_date: review_date + num_of_review)
  end


  private

  def set_default_review_date
    self.review_date = DateTime.current
  end


  def same_texts
    if sanitize_word(original_text) == sanitize_word(translated_text)
      errors.add(:translated_text, "Original and translated text can't be same!")
    end
  end

  def sanitize_word(string)
    string.mb_chars.downcase
  end
end