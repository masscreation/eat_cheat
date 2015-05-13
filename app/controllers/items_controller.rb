class ItemsController < ApplicationController
  def show

  end

  def new
    @item = Item.new

        
    search = params[:q]
    parse = "fields=item_name%2Citem_id%2Cnf_calories%2Cnf_total_fat%2Cnf_protein%2Cnf_total_carbohydrate%2Cnf_serving_weight_grams&appId=58809d9f&appKey=f0ee2e843b2e4a910d564ccebfc2c1dd" 
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

    puts "\n\n\n\n\n\n\n\n\n\n\n BEFORE CHANGE: #{@item.fat}"

    @item.fat *= 9
    @item.protein *= 4
    @item.carbs *= 4


    puts "\n\n\n AFTER CHANGE: #{@item.fat}"


    if @item.save 
      current_user.items << @item
      redirect_to items_path
    end
  end

  def index
    @items = Item.all
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:nutritionix_id, :calories, :fat, :protein, :carbs, :serving_weight_grams, :name)
  end
end
