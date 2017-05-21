if (u1 = User.find_by_email('admin@localhost')).nil?
  u1 = User.create!(password: 'qwerty', password_confirmation: 'qwerty',
    email: 'admin@localhost')
  u1.activate!
end
if (u2 = User.find_by_email('user@localhost')).nil?
  u2 = User.create!(password: 'qwerty', password_confirmation: 'qwerty',
    email: 'user@localhost')
  u2.activate!
end
r1, r2 = Role.create_main_roles
ru1 = RoleUser.create(role: r1, user: u1)
ru2 = RoleUser.create(role: r2, user: u2)

DishCategory.delete_all; Dish.destroy_all; Ingredient.destroy_all; DishesIngredient.destroy_all

n = 10

for i in 0 ... n
  DishCategory.create(name: "name" + i.to_s, position: i + 1)
  Dish.create(name: "name" + i.to_s, instruction: "instruction " + i.to_s, cooking_time: (i + 10).to_s)
  Ingredient.create(describe: "describe" + i.to_s)
end

for i in DishCategory.all
  if i != DishCategory.first
    i.parent = DishCategory.all[(0...n).to_a.shuffle[0]]
    i.save
  end
end

for i in Dish.all
  i.dish_categories << DishCategory.all[(0...n).to_a.shuffle[0]]
  d = DishesIngredient.new(n_ingredients: i.id)
  d.dish = i
  d.ingredient = Ingredient.all[(0...n).to_a.shuffle[0]]
  d.save
  d.dish = Dish.all[(0...n).to_a.shuffle[0]]
  d.ingredient = Ingredient.all[(0...n).to_a.shuffle[0]]
  d.save
end
for i in DishCategory.all
  i.dishes << Dish.all[(0...n).to_a.shuffle[0]]
end
