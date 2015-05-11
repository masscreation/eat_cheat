class ItemsController < ApplicationController
  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  end

  def index
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:nutritionix_id, :calories, :fat, :protein, :carbs, :serving_weight_grams, :name)
  end
end
