class DishesIngredientsController < ApplicationController
  before_action :set_dishes_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /dishes_ingredients
  # GET /dishes_ingredients.json
  def index
    @dishes_ingredients = DishesIngredient.all
  end

  # GET /dishes_ingredients/1
  # GET /dishes_ingredients/1.json
  def show
  end

  # GET /dishes_ingredients/new
  def new
    @dishes_ingredient = DishesIngredient.new
  end

  # GET /dishes_ingredients/1/edit
  def edit
  end

  # POST /dishes_ingredients
  # POST /dishes_ingredients.json
  def create
    @dishes_ingredient = DishesIngredient.new(dishes_ingredient_params)

    respond_to do |format|
      if @dishes_ingredient.save
        format.html { redirect_to @dishes_ingredient, notice: 'Dishes ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @dishes_ingredient }
      else
        format.html { render :new }
        format.json { render json: @dishes_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dishes_ingredients/1
  # PATCH/PUT /dishes_ingredients/1.json
  def update
    respond_to do |format|
      if @dishes_ingredient.update(dishes_ingredient_params)
        format.html { redirect_to @dishes_ingredient, notice: 'Dishes ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @dishes_ingredient }
      else
        format.html { render :edit }
        format.json { render json: @dishes_ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dishes_ingredients/1
  # DELETE /dishes_ingredients/1.json
  def destroy
    @dishes_ingredient.destroy
    respond_to do |format|
      format.html { redirect_to dishes_ingredients_url, notice: 'Dishes ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dishes_ingredient
      @dishes_ingredient = DishesIngredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dishes_ingredient_params
      params.require(:dishes_ingredient).permit(:n_ingredients)
    end
end
