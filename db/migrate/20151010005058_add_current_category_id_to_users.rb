class AddCurrentCategoryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :currrent_category_id, :integer
  end
end
