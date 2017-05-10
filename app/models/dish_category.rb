class DishCategory < ActiveRecord::Base
  belongs_to :parent, class_name: 'DishCategory', foreign_key: :dish_category_id
  has_many :dish_categories
  has_and_belongs_to_many :dishes

  validates :name, :position, presence: true
  validates :position, uniqueness: {scope: [:dish_category_id]}

  before_destroy :change_tree

  def change_tree
    # если есть родитель у удаляемой категории, то всех детей перевязать на неё с изменением
    # позиций детей на одном уровне
    if self.parent
      # проходим по всем детям удаляемой категории
      self.dish_categories.each do |d|
        # меняем позицию ребёнка на одном уровне путём нахождения
        # максимальной позиции среди уже имеющихся детей нужного родителя
        d.position = self.parent.dish_categories.pluck('position').max + 1
        d.save
        self.parent.dish_categories << d
      end
    end
  end

end
