class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :instruction
      t.time :cooking_time

      t.timestamps null: false

      t.index [:name], unique: true
    end
  end
end
