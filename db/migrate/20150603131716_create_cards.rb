class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :user, index: true
      t.text :original_text, :translated_text
      t.date :review_date

      t.timestamps
    end
  end
end
