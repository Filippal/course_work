class Ingredient < ActiveRecord::Base
  # has_and_belongs_to_many :dishes, through: :dishes_ingredients
  has_many :dishes_ingredients

  validates :describe, presence: true

  def self.attributes_names
    self.new.attributes.keys - ['created_at', 'updated_at']
  end
end
