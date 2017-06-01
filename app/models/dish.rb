class Dish < ActiveRecord::Base
  has_and_belongs_to_many :dish_categories
  # has_and_belongs_to_many :ingredients, through: :dishes_ingredients
  has_many :dishes_ingredients, dependent: :destroy

  accepts_nested_attributes_for :dishes_ingredients, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :instruction, presence: true
  validates :cooking_time, presence: true, numericality: {only_integer: true, greater_than: 0}

  def self.search(params)
    p1, p2, p3 = params["dish"], params["dish_category"], params["ingredient"]
    # eager_load = includes + references
    result = Dish.eager_load(:dish_categories, :dishes_ingredients, dishes_ingredients: :ingredient)
    # Поиск по полям блюд
    if p1[:name].present?
      result = result.where("dishes.name ilike ?", ?% + p1[:name] + ?%)
    end
    if p1[:instruction].present?
      result = result.where("dishes.instruction ilike ?", ?% + p1[:instruction] + ?%)
    end
    if p1[:cooking_time_from].present? && p1[:cooking_time_to].present?
      result = result.where("dishes.cooking_time BETWEEN ? AND ?",
        p1[:cooking_time_from], p1[:cooking_time_to])
    end

    # Поиск по полям категорий блюд
    if p2[:name].present?
      result = result.where("dish_categories.name ilike ?", ?% + p2[:name] + ?%)
    end

    # Поиск по полям ингредиента и связанной моделе ингредиент - блюдо
    unless p3[:disable].present?
      if p3[:name].present?
        result = result.where("ingredients.describe ilike ?", ?% + p3[:describe] + ?%)
      end
      if p3[:n_ingredients_from].present? && p3[:n_ingredients_to].present?
        result = result.where("dishes_ingredients.n_ingredients BETWEEN ? AND ?",
          p3[:n_ingredients_from], p3[:n_ingredients_to])
      end
    end

    result.all.uniq

  end
end
