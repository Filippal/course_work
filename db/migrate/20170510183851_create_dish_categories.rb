class CreateDishCategories < ActiveRecord::Migration
  def change
    create_table :dish_categories do |t|
      t.text :name, null: false
      t.integer :position, null: false

      t.timestamps null: false
    end
  end
end
