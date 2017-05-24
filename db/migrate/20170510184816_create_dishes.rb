class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.text :instruction, null: false
      t.text :cooking_time, null: false

      t.timestamps null: false

      t.index [:name], unique: true
    end
  end
end
