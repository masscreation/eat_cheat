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

#puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\Time at datefrom#{Time.at(@date_from.to_i+41400.seconds)}"

#puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\@midday_range#{@midday_range}"

#puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\@evening_range#{@evening_range}"




# Display Food for recipe & items
# Filter only info for today & 3 time categories

#.each statements below iterate through model associations
# to choose information from different levels

current_user.recipes.each do |recipe|

  #set summation of info back to 0
  @cal_per_recipe = 0
  @carb_per_recipe = 0
  @prot_per_recipe = 0
  @fat_per_recipe = 0


  @sum_of_cal = 0

  recipe.meals.each do |meal|
    
    meal.recipe.items.each do |item|

      #Filter info only for today
      if (meal.time_eaten.day == @today.day)

        #Filter info for Morning, Midday and Evening
        #MORNING:
        if (meal.time_eaten.hour.between?(0,11.5))

          #sum info for each recipe's items ->applestrudle: apple cal + flour cal
          @cal_per_recipe += item.calories.round(1)
          @carb_per_recipe += item.carbs.round(1)
          @prot_per_recipe += item.protein.round(1)
          @fat_per_recipe += item.fat.round(1)

          #create array with all recipes eaten for morning
          @food_morning << { 'name': meal.recipe.name, 'calories': @cal_per_recipe, 'carbs': @carb_per_recipe, 
          'protein': @prot_per_recipe, 'fat': meal.time_eaten}
        end

        # MIDDAY:
        if (meal.time_eaten.hour.between?(11.51,17.5))
          @cal_per_recipe += item.calories.round(1)
          @carb_per_recipe += item.carbs.round(1)
          @prot_per_recipe += item.protein.round(1)
          @fat_per_recipe += item.fat.round(1)

          #create array with all recipes eaten for midday
          @food_midday << { 'name': meal.recipe.name, 'calories': @cal_per_recipe, 'carbs': @carb_per_recipe, 
          'protein': @prot_per_recipe, 'fat': meal.time_eaten}
        end

        # EVENING:
        if (meal.time_eaten.hour.between?(17.51,23.99))
        @cal_per_recipe += item.calories.round(1)
        @carb_per_recipe += item.carbs.round(1)
        @prot_per_recipe += item.protein.round(1)
        @fat_per_recipe += item.fat.round(1)

        #create array with all recipes eaten for evening
        @food_evening << { 'name': meal.recipe.name, 'calories': @cal_per_recipe, 'carbs': @carb_per_recipe, 
        'protein': @prot_per_recipe, 'fat': meal.time_eaten}
        end

      end #if filter today
        #connect recipe-data for charts
        meal.recipe.items.each do |item|
          @fat += item.fat
          @protein += item.protein
          @carbs += item.carbs
        end
    end #3-do
  end #2-do
end #1-do     


# # Display Food

# #iterate through models to choose information
# current_user.recipes.each do |recipe|

#   #set summation of info back to 0
#   @cal_per_recipe = 0
#   @carb_per_recipe = 0
#   @prot_per_recipe = 0
#   @fat_per_recipe = 0

#     recipe.meals.each do |meal|
    
#      meal.recipe.items.each do |item|

# #Select info for Morning, Midday and Evening
# #MIDDAY:
# if (meal.time_eaten.hour.between?(11.6,17.5))
# @cal_per_recipe += item.calories.round(1)
# @carb_per_recipe += item.carbs.round(1)
# @prot_per_recipe += item.protein.round(1)
# @fat_per_recipe += item.fat.round(1)
#  @food_midday << { 'name': meal.recipe.name, 'calories': @cal_per_recipe, 'carbs': @carb_per_recipe, 
#   'protein': @prot_per_recipe, 'fat': meal.time_eaten}
# end
# end

# end
# end 

# # Display Food

# #iterate through models to choose information
# current_user.recipes.each do |recipe|

#   #set summation of info back to 0
#   @cal_per_recipe = 0
#   @carb_per_recipe = 0
#   @prot_per_recipe = 0
#   @fat_per_recipe = 0

#     recipe.meals.each do |meal|
    
#      meal.recipe.items.each do |item|

# #Select info for Morning, Midday and Evening
# #EVENING:
# if (meal.time_eaten.hour.between?(17.6,23.9))
# @cal_per_recipe += item.calories.round(1)
# @carb_per_recipe += item.carbs.round(1)
# @prot_per_recipe += item.protein.round(1)
# @fat_per_recipe += item.fat.round(1)
#  @food_evening << { 'name': meal.recipe.name, 'calories': @cal_per_recipe, 'carbs': @carb_per_recipe, 
#   'protein': @prot_per_recipe, 'fat': meal.time_eaten}
# end
# end

# end
# end 




        #       recipe.ingredients.each do |ingred|
        #       recipe.meals.each do |meal|

              
        #         if (meal.time_eaten.hour.between?(0,11.5))
        #             @food_morning << { 'name': ingred.item.name,
        #           'fat': ingred.item.fat, 'protein': ingred.item.protein, 'carbs': ingred.item.carbs, 'calories': ingred.item.calories}
                  

        #           @food_morning << { 'name': meal.recipe.name,
        #           'fat': meal.recipe.item.fat, 'protein': ingred.item.protein, 'carbs': ingred.item.carbs, 'calories': ingred.item.calories}
                
        #         elsif (meal.time_eaten.hour.between?(11.6,17.5))
        #             @food_midday << { 'name': ingred.item.name,
        #             'fat': ingred.item.fat, 'protein': ingred.item.protein, 'carbs': ingred.item.carbs, 'calories': ingred.item.calories}
                
        #         else (meal.time_eaten.hour.between?(17.6,23.9))
        #            @food_evening << { 'name': ingred.item.name,
        #           'fat': ingred.item.fat, 'protein': ingred.item.protein, 'carbs': ingred.item.carbs, 'calories': ingred.item.calories}
        #         end
              
        #     end
        #     end
        #     end

        #     current_user.recipes.each do |recipe|
        #       recipe.meals.each do |meal|

        #         #select only food eaten in morning
        #         if (meal.time_eaten.hour.between?(0,11.5))
        #             @food_morning << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name} 
        #             #, 'fat': meal.recipe.item.fat, 'protein': meal.recipe.item.protein, 'carbs': meal.recipe.item.carbs, 'calories': meal.recipe.item.calories
        #         elsif (meal.time_eaten.hour.between?(11.6,17.5))
        #             @food_midday << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}
        #         else (meal.time_eaten.hour.between?(17.6,23.9))
        #            @food_evening << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}              
        #         end

                # #connect recipe-data for charts
                #   meal.recipe.items.each do |item|
                #     @fat += item.fat
                #     @protein += item.protein
                #     @carbs += item.carbs
        #           end
        #       end
        #     end



        # #create array for today's item data
        # #same thing for items -> run through item.meals
        #   @items.each do |item|
        #     item.meals.each do |meal|
           
        #         #select items only eaten today
        #         if (meal.time_eaten.hour.between?(0,11.5))
        #             @food_morning << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories } 
        #         elsif (meal.time_eaten.hour.between?(11.6,17.5))
        #             @food_midday << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories } 
        #         else (meal.time_eaten.hour.between?(17.6,23.9))
        #            @food_evening << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories }            
        #         end
                  
        #           #connect recipe-data for charts
        #           @fat += meal.item.fat
        #           @protein += meal.item.protein
        #           @carbs += meal.item.carbs
        #     end
        # end



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


