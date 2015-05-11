class RecipesController < ApplicationController
  def show
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

  end

  def destroy
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :user_id)
  end
end
