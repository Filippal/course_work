class DishesIngredient < ActiveRecord::Base
  belongs_to :dish
  belongs_to :ingredient

  validates :n_ingredients, presence: true
  validates :dish_id, uniqueness: {scope: [:ingredient_id]}

  accepts_nested_attributes_for :ingredient

  def self.attributes_names
    self.new.attributes.keys - ['created_at', 'updated_at']
  end
end
