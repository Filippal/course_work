class Dish < ActiveRecord::Base
  has_and_belongs_to_many :dish_categories
  # has_and_belongs_to_many :ingredients, through: :dishes_ingredients
  has_many :dishes_ingredients, dependent: :destroy

  accepts_nested_attributes_for :dishes_ingredients, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :instruction, presence: true
  validates :cooking_time, presence: true, numericality: {only_integer: true, greater_than: 0}

  def self.search(params)
    query = Dish.eager_load(:dishes_ingredients, :dish_categories, :ingredient)
    params.each do |entity, hsh|
      hsh.each do |atr, val|
        next if val.nil? || val.to_s.blank?
        query = query.where( entity.pluralize.to_sym => {atr => val} )
      end
    end
    return query
  end

  def self.attributes_names
    self.new.attributes.keys - ['created_at', 'updated_at']
  end
end
