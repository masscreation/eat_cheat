class ProfilesController < ApplicationController


	def index
    @user = current_user
    @meal = Meal.new
    @recipe_options = current_user.recipes.map { |recipe| [recipe.name, recipe.id] }
    @item_options = current_user.items.map { |item| [item.name, item.id] }
    @items = current_user.items

    #info charts
    @fat = 0
    @protein = 0
    @carbs = 0

    #associate food with time_eaten:
	@today = Time.new
	@food_for_today = []
    @food_morning = []
    @food_midday = []
    @food_evening = []
    #date_range used to diplay data
    # @date_from = params[:@date_from]
    # @date_til = params[:@date_til]
    # @date_range = (@date_from.to_i..@date_til.to_i)
    # @morning_range = (@date_from.to_i..@date_from.to_i+41400.seconds)
    # @midday_range = (@date_from.to_i+41400.seconds..@date_til.to_i-7.hours) 
    # @evening_range = (@date_til.to_i-7.hours..@date_til.to_i) 

puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\Time at datefrom#{Time.at(@date_from.to_i+41400.seconds)}"

puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\@midday_range#{@midday_range}"

puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\@evening_range#{@evening_range}"



            current_user.recipes.each do |recipe|
              recipe.meals.each do |meal|

                #select only food eaten in morning
                if (meal.time_eaten.hour.between?(0,11.5))
                    @food_morning << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name} 
                    #, 'fat': meal.recipe.item.fat, 'protein': meal.recipe.item.protein, 'carbs': meal.recipe.item.carbs, 'calories': meal.recipe.item.calories
                elsif (meal.time_eaten.hour.between?(11.6,17.5))
                    @food_midday << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}
                else (meal.time_eaten.hour.between?(17.6,23.9))
                   @food_evening << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}              
                end

                #connect recipe-data for charts
                  meal.recipe.items.each do |item|
                    @fat += item.fat
                    @protein += item.protein
                    @carbs += item.carbs
                  end
              end
            end



        #create array for today's item data
        #same thing for items -> run through item.meals
          @items.each do |item|
            item.meals.each do |meal|
           
                #select items only eaten today
                if (meal.time_eaten.hour.between?(0,11.5))
                    @food_morning << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories } 
                elsif (meal.time_eaten.hour.between?(11.6,17.5))
                    @food_midday << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories } 
                else (meal.time_eaten.hour.between?(17.6,23.9))
                   @food_evening << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories }            
                end
                  
                  #connect recipe-data for charts
                  @fat += meal.item.fat
                  @protein += meal.item.protein
                  @carbs += meal.item.carbs
            end
        end



# => In case I want to display data in a range
#             current_user.recipes.each do |recipe|
#               recipe.meals.each do |meal|
#                 #select only food eaten in morning]

#                 if (meal.time_eaten.to_i.between?(@date_from.to_i, @date_from.to_i+41400.seconds))
#                   @food_morning << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}
#                 elsif (meal.time_eaten.to_i.between?(@date_from.to_i+41400.seconds, @date_til.to_i-7.hours))
#                   @food_midday << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}
#                 else (meal.time_eaten.to_i.between?(@date_til.to_i-7.hours, @date_til.to_i))
#                   @food_evening << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}              
#                 end

#                   #connect recipe-data for charts
#                   meal.recipe.items.each do |item|
#                     @fat += item.fat
#                     @protein += item.protein
#                     @carbs += item.carbs
#                   end
                  
#               end
#             end



  

        #authorize
  		if !user_signed_in?
  			redirect_to '/users/sign_in'
  		end

  end #end-index

end #end-class


