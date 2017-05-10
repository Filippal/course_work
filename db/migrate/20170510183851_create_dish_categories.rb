class CreateDishCategories < ActiveRecord::Migration
  def change
    create_table :dish_categories do |t|
      t.text :name
      t.integer :position

      t.timestamps null: false
    end
  end
end
