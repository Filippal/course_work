select_choose_position = ->
  $("#dish_category_position").attr("value", $("option:selected").attr("position"))
  $("#dish_category_dish_category_id").change(->
    $("#dish_category_position").attr("value", $("option:selected").attr("position"))
  )

$(document).ready select_choose_position
$(document).on 'page:load', select_choose_position
