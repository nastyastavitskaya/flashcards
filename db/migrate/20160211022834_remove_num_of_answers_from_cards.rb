class RemoveNumOfAnswersFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :num_of_incorrect_answers
    remove_column :cards, :num_of_correct_answers
  end
end
