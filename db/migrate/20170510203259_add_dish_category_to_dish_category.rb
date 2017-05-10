class AddDishCategoryToDishCategory < ActiveRecord::Migration
  def change
    add_reference :dish_categories, :dish_category, index: true, foreign_key: true
    add_index :dish_categories, [:dish_category_id, :position], unique: true
  end
end
