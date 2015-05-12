class IngredientsController < ApplicationController
  def index 
    
  end

  def new
    @item_options = Item.all.map { |item| [item.name, item.id] }
    @ingredient = Ingredient.new
  end

  def create 
  end

  def edit
    
  end
end
