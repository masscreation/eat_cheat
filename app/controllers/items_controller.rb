class ItemsController < ApplicationController
  def show
  end

  def new
    @item = Item.new

        
    search = params[:q]
    parse = "fields=item_name&appId=58809d9f&appKey=f0ee2e843b2e4a910d564ccebfc2c1dd" 
    if search 
        resp = Typhoeus.get("https://api.nutritionix.com/v1_1/search/#{search}", params: parse)
        @items = JSON.parse(resp.body)['hits']
        # render json: @items
        puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n #{@items}"
    else
        @items = []
    end

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
