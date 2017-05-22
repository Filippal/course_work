module IngredientsHelper
  def new_ingredient_form(form)
    new_object = Ingredient.new
    form.fields_for(:ingredient, new_object) do |ar|
      render('dishes/one_ingredient_form', ar: ar)
    end
  end
end
