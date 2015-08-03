class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :original_text, :translated_text
      t.date :review_date
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
