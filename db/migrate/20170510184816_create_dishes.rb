class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :instruction
      t.text :cooking_time

      t.timestamps null: false

      t.index [:name], unique: true
    end
  end
end
