module DishesIngredientsHelper
  def link_to_add_dishes_ingredients(form)
    new_object = DishesIngredient.new()
    fields = form.fields_for(:dishes_ingredients, new_object,
      :child_index => 'new_d_i') do |fr|
      render('dishes/one_dishes_ingredients_form', fr: fr, i: 'Новая')
    end
    # Ссылка будет обрабатываться javascript-ом поэтому адрес фиктивный
    link_to(?#, class: 'btn btn-info',
        id: 'add_d_i_link', data: {content: "#{fields}"}) do
      fa_icon("plus") + " Новая связь"
    end
  end

  def link_to_remove_dishes_ingredients(form)
    form.hidden_field(:_destroy, class: 'remove_fields') +
        # Ссылка будет обрабатываться javascript-ом поэтому адрес фиктивный
        link_to(?#, class: 'remove_fields remove_d_i') do
      fa_icon('times', title: 'Удалить связь') + ' Удалить'
    end
  end
end
