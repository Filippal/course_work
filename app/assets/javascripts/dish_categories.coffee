select_choose_position = ->
  $("#dish_category_position").attr("value", $("option:selected").attr("position"))
  $("#dish_category_dish_category_id").change(->
    $("#dish_category_position").attr("value", $("option:selected").attr("position"))
  )

@delete_one_dish = (link)->
  if confirm("Вы уверены?")
    link.parent().find("input[type=hidden].remove_fields").first().val("1")
    link.parent().parent().parent().parent().hide()
# Включаем все кнопки удаления
@del_all_dishes = ->
  $('a.remove_dish').on 'click', ->
    window.delete_one_dish($(this))
    false
  false

@add_new_dish = ->
  $('#add_dish_link').on 'click', ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_dish", "g")
    content = $(this).attr('data-content')
    content = content.replace(regexp, new_id)
    # Вставляем на страницу
    $(this).parent().parent().after(content)
    panel = $(this).parent().parent().parent().find('.panel-info').first()

    panel.find('a.remove_dish').on 'click', ->
      window.delete_one_dish($(this))
      false
    false
# Запуск всего вышеописанного
dish_ready = ->
  window.add_new_dish()
  window.del_all_dishes()
  select_choose_position()

$(document).on 'page:load', dish_ready # Включаем при ajax обновлении страницы
$(document).ready dish_ready # Включаем при обычном обновлении страницы
