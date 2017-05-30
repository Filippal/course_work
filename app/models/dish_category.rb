class DishCategory < ActiveRecord::Base
  belongs_to :parent, class_name: 'DishCategory', foreign_key: :dish_category_id
  has_many :dish_categories
  has_and_belongs_to_many :dishes

  validates :name, :position, presence: true
  validates :position, uniqueness: {scope: [:dish_category_id]},
    numericality: {only_integer: true, greater_than: 0}

  before_destroy :change_tree

  before_save :check_parent_self

  accepts_nested_attributes_for :dishes, allow_destroy: true

  private

  # перестройка дерева перед удалением
  def change_tree
    # проходим по всем детям удаляемой категории
    self.dish_categories.each do |d|
      # если есть родитель у удаляемой категории, то всех детей перевязать на неё с изменением
      # позиций детей на одном уровне
      if self.parent
        # меняем позицию ребёнка на одном уровне
        d.position = DishCategory.find_first_empty_space( self.parent.dish_categories.pluck('position') )
        d.parent = self.parent
      else
        d.position = DishCategory.find_first_empty_space( DishCategory.where(dish_category_id: nil).pluck(:position) )
        d.parent = nil
      end
      d.save
    end
  end

  # находит нужную позицию позицию, чтобы не оставалось незанятых
  # Например были позиции 1 2 3, при этом удалили 2, стало 1 3.
  # Данная функция находит ту самую вторую позицию.
  def self.find_first_empty_space(mas)
    return 1 if mas.empty?
    mas.sort!
    mas.each_with_index do |elem, index|
      return 1 if elem != index + 1 && index == 0
      if elem != index + 1
        return mas[index - 1] + 1
      elsif mas.size - 1 == index
        return mas[-1] + 1
      end
    end
  end


  def check_parent_self
    # Выбираем нужную позицию
    if parent
      # выбор позиции, среди детей родителя
      vals = parent.dish_categories.pluck("position")
      # Если детей нет у текущего родителя, то позиция первого ребёнка = 1
      self.position = DishCategory.find_first_empty_space( vals )
    else
      self.position = DishCategory.find_first_empty_space( DishCategory.where(dish_category_id: nil).pluck(:position) )
    end

    # устраняем петли
    obj1, obj2 = parent, parent
    # проверка, не сыылается ли объект сам на себя
    if obj1 == self
      return false
    else
      obj1 = obj1.try("parent")
    end

    while obj1
      # если находим один из родительских объектов, который ссылается на текущий,
      # то это петля, которую устраняем отвязыванием того элемента, который
      # ссылается на текущий одного из его же родителей
      if obj1 == self
        # Объект становится одним из корневых верших
        obj2.parent = nil
        obj2.position = DishCategory.find_first_empty_space( DishCategory.where(dish_category_id: nil).pluck(:position) )
        obj2.save
        return true
      end
      obj2 = obj1
      obj1 = obj1.parent
    end
    true
  end

  def self.attributes_names
    self.new.attributes.keys - ['created_at', 'updated_at']
  end
end
