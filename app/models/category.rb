class Category < ActiveRecord::Base
  validates :name, :user_id, presence: true

  has_many :cards
  belongs_to :user
end
