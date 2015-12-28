class Card < ActiveRecord::Base
  validates :original_text,
            :translated_text, presence: true


  validate :same_texts

  before_create :set_default_review_date

  belongs_to :category

  mount_uploader :image, ImageUploader

  scope :to_review, -> { where("review_date <= ?", Time.current).order('RANDOM()') }

  def self.create_with_category(params)
    category_params = params.delete(:category)
    if params[:category_id].blank?
      @category = Category.create(category_params)
      params.deep_merge!(category_id: @category.id)
    end
    create(params)
  end


  def check_translation(user_translated_text)
    @result = case Levenshtein.distance(user_translated_text, translated_text)
    when 0
      update_num_of_correct_answers
      :correct
    when 1, 2
      :typo
    else
      update_num_of_incorrect_answers
      :wrong
     end
  end

  def update_num_of_correct_answers
    update_attributes(num_of_incorrect_answers: 0)
    increment(:num_of_correct_answers) if num_of_correct_answers < 5
    update_review_date
  end

  def update_num_of_incorrect_answers
    decrement(:num_of_correct_answers) if num_of_correct_answers > 0
    increment(:num_of_incorrect_answers) if num_of_incorrect_answers < 3
    if num_of_incorrect_answers >= 3
      update_attributes(num_of_correct_answers: 0, review_date: review_date + 12.hours)
    end
  end

  def update_review_date
    review_number = case num_of_correct_answers
      when 0
        0
      when 1
        12.hours
      when 2
        3.days
      when 3
        7.days
      when 4
        14.days
      else
        1.month
      end
    update_attributes(review_date: review_date + review_number)
  end



  private

  def set_default_review_date
    self.review_date = Time.current
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