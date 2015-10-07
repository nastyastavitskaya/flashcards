class AddCategoryIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :category_id, :integer
  end
end
