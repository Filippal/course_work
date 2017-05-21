class DishesIngredient < ActiveRecord::Base
  belongs_to :dish
  belongs_to :ingredient

  validates :n_ingredients, :dish_id, :ingredient_id, presence: true
  validates :dish_id, uniqueness: {scope: [:ingredient_id]}

  accepts_nested_attributes_for :ingredient
end
