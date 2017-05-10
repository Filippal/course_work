class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :dishes, through: :dishes_ingredients
  has_many :dishes_ingredients

  validates :describe, presence: true
end
