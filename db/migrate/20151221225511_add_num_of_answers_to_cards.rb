class AddNumOfAnswersToCards < ActiveRecord::Migration
  def change
    add_column :cards, :num_of_answers, :integer, default: 0
  end
end
