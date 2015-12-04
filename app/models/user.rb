class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  belongs_to :current_category, class_name: "Category"

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :categories, dependent: :destroy
  has_many :cards, through: :categories

  validates :name, presence: true, length: { in: 3..30 }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true,
                    email_format: { message: "has invalid format" }


  # before_save :downcase_email


  # def downcase_email
  #   self.email = email.downcase
  # end

  def pending_cards
    if current_category
      current_category.cards.order('RANDOM()')
    else
      cards.to_review
    end
  end
end
