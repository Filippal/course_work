module DishCategoriesHelper
  # При выборе родителя в дереве категории блюд, автоматически записывается в скрытое поле позиция
  # на одном уровне с другими категориями в дереве.
  # Записывается это поле скриптом из атрибута position тега option в f.hidden_field :position
  # см. dish_categories.coffee
  def options_parent(dish_category)
    # Если не относится ни к какой, то позицию надо менять в соответствии со всеми корнями деревьев
    pos = DishCategory.find_first_empty_space( DishCategory.where(dish_category_id: nil).pluck(:position) )
    mas = [["Не относится ни к какой", "", {'position': pos}]]
    DishCategory.all.map do |d|
      next if d == dish_category
      # выбор позиции, среди детей выбранного родителя
      vals = d.dish_categories.pluck("position")
      # Если детей нет у текущего родителя, то позиция первого ребёнка = 1
      mas << [ d.name, d.id, {'position': vals.empty? ? 1 : DishCategory.find_first_empty_space( vals )} ]
    end
    mas
  end

  # def options_parent(dish_category)
  #   mas = [["Не относится ни к какой", ""]]
  #   DishCategory.all.map{|x| mas << [x.name, x.id] unless x == dish_category}
  #   mas
  # end
end
