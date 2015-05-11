class RecipesController < ApplicationController
  def show
    @user = current_user
    @recipes = current_user.recipes
  end

  def index
    @user = current_user
    @recipes = current_user.recipes
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.new(recipe_params)
    @user.recipes << @recipe 
    if @recipe.save
      redirect_to :root
    end
  end

  def edit
    @user = current_user
    @recipe = Recipe.find(params[:id])
    @items = Item.all
  end

  def update
    if @recipe.update?
      redirect_to @recipe
    end
  end

  def destroy
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :user_id, :ingredient_attributes=>[:quant_of_item_eaten])
  end
    
end
