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
    #date_range used to diplay data
    @date_from = params[:@date_from]
    @date_til = params[:@date_til]
    @date_range = (@date_from.to_i..@date_til.to_i)

        #create array for today's recipe data
        #run through recipe.meals 
        current_user.recipes.each do |recipe|
              recipe.meals.each do |meal|

                #select only food eaten today
                if (@date_range.cover?(meal.time_eaten.to_i))
                   

                  #connect recipe-data for charts
                  meal.recipe.items.each do |item|
                    @fat += item.fat
                    @protein += item.protein
                    @carbs += item.carbs
                  end

                  #push variables from recipe into array for food eaten today
                  @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name}
                  #next step display also further details
                  #, 'fat': meal.recipe.fat, 'protein': meal.recipe.protein, 'carbs': meal.recipe.carbs, 'calories': meal.recipe.calories
                end
              end
        end


        #create array for today's item data
        #same thing for items -> run through item.meals
    		@items.each do |item|
    			item.meals.each do |meal|
            
            #select items only eaten today
      			if (@date_range.cover?(meal.time_eaten.to_i))
                @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories } 
                  
                  #connect recipe-data for charts
                  @fat += meal.item.fat
                  @protein += meal.item.protein
                  @carbs += meal.item.carbs
                  @total_calories = @fat + @protein + @carbs
            end
		      end
	      end

            #test out elements
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#{@food_for_today}"
   

            #Repeat the same as above to specify morning 
            @food_for_today_morning = []

            # @items.each do |item|
            #       item.meals.each do |meal|
            #             if ( ADD RANGE HERE)
            #                   @food_for_today_morning << @food_for_today

            #                     @fat += meal.item.fat
            #                     @protein += meal.item.protein
            #                     @carbs += meal.item.carbs
            #             end
            #       end
            # end



      #authorize
  		if !user_signed_in?
  			redirect_to '/users/sign_in'
  		end
	end

end


