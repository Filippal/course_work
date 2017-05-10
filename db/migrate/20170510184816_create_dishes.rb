class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :instruction
      t.time :cooking_time
      t.text :technique

      t.timestamps null: false
    end
  end
end
