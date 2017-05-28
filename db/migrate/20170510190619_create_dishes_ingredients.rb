class CreateDishesIngredients < ActiveRecord::Migration
  def change
    create_table :dishes_ingredients do |t|
      t.string :n_ingredients, null: false
      t.references :dish, index: true, foreign_key: true, null: false
      t.references :ingredient, index: true, foreign_key: true, null: false

      t.timestamps null: false

      t.index [:dish_id, :ingredient_id], unique: true
    end
  end
end
