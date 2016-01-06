class ChangeNumOfReview < ActiveRecord::Migration
  def change
    rename_column :cards, :num_of_review, :num_of_incorrect_answers
  end
end
