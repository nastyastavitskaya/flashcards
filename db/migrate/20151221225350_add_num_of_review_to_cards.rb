class AddNumOfReviewToCards < ActiveRecord::Migration
  def change
    add_column :cards, :num_of_review, :integer, default: 0
  end
end
