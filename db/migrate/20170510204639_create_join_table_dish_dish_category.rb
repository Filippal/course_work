class CreateJoinTableDishDishCategory < ActiveRecord::Migration
  def change
    create_join_table :dishes, :dish_categories do |t|
      t.index [:dish_id, :dish_category_id]
      t.index [:dish_category_id, :dish_id]
    end
  end
end
