# Обработка кнопки добавления существующих блюд
add_dishes = ->
  $("#add-exist-dish").click ->
    val = $("#dishes-select").val()
    if($("#dish-" + val).length == 0)
      text = $("#dishes-select option:selected").text()
      $("<div class='dish-elem' id='dish-" + val + "'>" + text + "</div>").appendTo($("#list-exist-dishes"))
      $("#dish_category_dish_ids").val($("#dish_category_dish_ids").val() + ' ' + val)

remove_dishes = ->
  $("#remove-exist-dish").click ->
    val = $("#dishes-select").val()
    $("#dish-" + val).remove()
    $("#dish_category_dish_ids").val( $("#dish_category_dish_ids").val().replace(val, '') )

actions_dish = ->
  add_dishes()
  remove_dishes()

$(document).ready actions_dish
$(document).on 'page:load', actions_dish
