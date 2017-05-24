class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.text :describe, null: false

      t.timestamps null: false
    end
  end
end
