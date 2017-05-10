json.extract! dish, :id, :name, :instruction, :cooking_time, :technique, :created_at, :updated_at
json.url dish_url(dish, format: :json)
