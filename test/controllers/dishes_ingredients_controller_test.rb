require 'test_helper'

class DishesIngredientsControllerTest < ActionController::TestCase
  setup do
    @dishes_ingredient = dishes_ingredients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dishes_ingredients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dishes_ingredient" do
    assert_difference('DishesIngredient.count') do
      post :create, dishes_ingredient: { n_ingredients: @dishes_ingredient.n_ingredients }
    end

    assert_redirected_to dishes_ingredient_path(assigns(:dishes_ingredient))
  end

  test "should show dishes_ingredient" do
    get :show, id: @dishes_ingredient
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dishes_ingredient
    assert_response :success
  end

  test "should update dishes_ingredient" do
    patch :update, id: @dishes_ingredient, dishes_ingredient: { n_ingredients: @dishes_ingredient.n_ingredients }
    assert_redirected_to dishes_ingredient_path(assigns(:dishes_ingredient))
  end

  test "should destroy dishes_ingredient" do
    assert_difference('DishesIngredient.count', -1) do
      delete :destroy, id: @dishes_ingredient
    end

    assert_redirected_to dishes_ingredients_path
  end
end
