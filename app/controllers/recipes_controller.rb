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
    @item_options = Item.all.map { |item| [item.name, item.id] }
    @ingredient = Ingredient.new
  end

  def update
      @user = current_user
      @recipe = Recipe.find(params[:id])
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n  #{@recipe.name}"

      #need to update ingredients to set quantity used
      @ingredient = params["recipe"]["ingredient"]
      puts "#{@ingredient["item_id"]}"


      @recipe.ingredients << @ingredient
      #need to associate item with recipe


      redirect_to :root
    
  end

  def destroy
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :user_id, :ingredient_attributes=>[:quant_of_item_eaten])
  end
    
end
