class ChangeNumOfAnswers < ActiveRecord::Migration
  def change
    rename_column :cards, :num_of_answers, :num_of_correct_answers
  end
end
