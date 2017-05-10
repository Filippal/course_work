class CreateDishesIngredients < ActiveRecord::Migration
  def change
    create_table :dishes_ingredients do |t|
      t.string :n_ingredients

      t.timestamps null: false
    end
  end
end
