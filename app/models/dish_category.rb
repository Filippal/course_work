class DishCategory < ActiveRecord::Base
  belongs_to :parent, class_name: 'DishCategory', foreign_key: :dish_category_id
  has_many :dish_categories
  has_and_belongs_to_many :dishes

  validates :name, :position, presence: true
  validates :position, uniqueness: {scope: [:dish_category_id]},
    numericality: {only_integer: true, greater_than: 0}

  before_destroy :change_tree

  accepts_nested_attributes_for :parent

  private

  # перестройка дерева перед удалением
  def change_tree
    # если есть родитель у удаляемой категории, то всех детей перевязать на неё с изменением
    # позиций детей на одном уровне
    if self.parent
      # проходим по всем детям удаляемой категории
      self.dish_categories.each do |d|
        # меняем позицию ребёнка на одном уровне путём нахождения
        # максимальной позиции среди уже имеющихся детей нужного родителя
        d.position = find_first_empty_space( self.parent.dish_categories.pluck('position') )
        d.save
        self.parent.dish_categories << d
      end
    end
  end

  # находит нужную позицию позицию, чтобы не оставалось незанятых
  # Например были позиции 1 2 3, при этом удалили 2, стало 1 3.
  # Данная функция находит ту самую вторую позицию.
  def self.find_first_empty_space(mas)
    mas.each_with_index{|elem, index| return mas[index - 1] + 1 if elem != index + 1}
  end

end
