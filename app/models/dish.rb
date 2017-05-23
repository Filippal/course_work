class Dish < ActiveRecord::Base
  has_and_belongs_to_many :dish_categories
  # has_and_belongs_to_many :ingredients, through: :dishes_ingredients
  has_many :dishes_ingredients

  accepts_nested_attributes_for :dishes_ingredients, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :instruction, presence: true
  validates :cooking_time, presence: true, numericality: {only_integer: true, greater_than: 0}

end
