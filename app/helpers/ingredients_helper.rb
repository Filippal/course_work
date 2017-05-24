module IngredientsHelper
  def ingredient_options(cur_id)
    Ingredient.all.map do |x|
      cur_id == x.id ? [x.describe + " (текущий)", x.id] : [x.describe, x.id]
    end
  end

  def new_ingredient_form(form)
    form.fields_for(:ingredient, Ingredient.new) do |ar|
      render 'dishes/ingredient_fields', ar: ar
    end
  end

  def exist_ingredient_form(form)
    form.fields_for(:ingredient) do |ar|
      render 'dishes/ingredient_fields', ar: ar
    end
  end
end
