class RecipesController < ApplicationController
  def show
    @user = current_user
    @recipes = current_user.recipes
    @recipe = Recipe.find(params[:id])
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
      @recipe = Recipe.find(params[:id])
      puts "\n\n\n\n\n\n\n\n\n\n\n\n\n  #{@recipe.name}"
     

      @item = Item.find(params["recipe"]["ingredient"]["item_id"])
      puts "#{@item}"

      #associates the found item with the recipe
      @recipe.items <<  @item

      @quant = params["recipe"]["ingredient"]["quant_of_item_eaten"]
      @ingredients = Ingredient.where(recipe_id: @recipe.id)

      @ingredients.each do |x|
        x.update_attribute('quant_of_item_eaten', @quant)
      end

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
