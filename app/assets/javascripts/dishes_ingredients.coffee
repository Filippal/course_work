change_form_ingredient = ->
  $(".ingredient-select").change ->
    elem = $(this).parent().parent().parent().next().find(".ingredient-main-fields")
    if ($(this).val() == $(this).attr("data-current-id"))
      elem.html(elem.attr("data-content-exist"))
    else if ($(this).val() == "")
      elem.html(elem.attr("data-content-new"))
    else
      elem.html("")

# Удаление связи блюдо - ингредиент
@delete_one_d_i = (link)->
  if confirm("Вы уверены?")
    link.parent().find("input[type=hidden].remove_fields").first().val("1")
    link.parent().parent().parent().parent().hide()
# Включаем все кнопки удаления
@del_all_d_i = ->
  $('a.remove_d_i').on 'click', ->
    window.delete_one_d_i($(this))
    false
  false
# Включаем кнопку добавления роли
@add_new_d_i = ->
  $('#add_d_i_link').on 'click', ->
    # Подменяем временный id с фразой new_ru на случайной число
    new_id = new Date().getTime()
    regexp = new RegExp("new_d_i", "g")
    content = $(this).attr('data-content')
    content = content.replace(regexp, new_id)
    # Вставляем на страницу
    $(this).parent().parent().after(content)

    elem = $(this).parent().parent().next().find(".ingredient-main-fields")
    elem.html(elem.attr("data-content-new"))
    change_form_ingredient()
    
    panel = $(this).parent().parent().parent().find('.panel-info').first()
    panel.find('a.remove_d_i').on 'click', ->
      window.delete_one_d_i($(this))
      false
    false
# Запуск всего вышеописанного
d_i_ready = ->
  window.add_new_d_i()
  window.del_all_d_i()
  change_form_ingredient()

$(document).on 'page:load', d_i_ready # Включаем при ajax обновлении страницы
$(document).ready d_i_ready # Включаем при обычном обновлении страницы
# nested_finish
