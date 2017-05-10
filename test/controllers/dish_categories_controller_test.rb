require 'test_helper'

class DishCategoriesControllerTest < ActionController::TestCase
  setup do
    @dish_category = dish_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dish_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dish_category" do
    assert_difference('DishCategory.count') do
      post :create, dish_category: { name: @dish_category.name, position: @dish_category.position }
    end

    assert_redirected_to dish_category_path(assigns(:dish_category))
  end

  test "should show dish_category" do
    get :show, id: @dish_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dish_category
    assert_response :success
  end

  test "should update dish_category" do
    patch :update, id: @dish_category, dish_category: { name: @dish_category.name, position: @dish_category.position }
    assert_redirected_to dish_category_path(assigns(:dish_category))
  end

  test "should destroy dish_category" do
    assert_difference('DishCategory.count', -1) do
      delete :destroy, id: @dish_category
    end

    assert_redirected_to dish_categories_path
  end
end
