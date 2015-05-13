class ProfilesController < ApplicationController

	def index
		@user = current_user
		@meal = Meal.new
		@recipe_options = current_user.recipes.map { |recipe| [recipe.name, recipe.id] }
		@item_options = Item.all.map { |item| [item.name, item.id] }
		@items = Item.all

            #associate food with time_eaten:

		@today = Time.new
		@food_for_today = []
            @date_from = params[:@date_from]
            @date_til = params[:@date_til]
            @date_range = (@date_from.to_i..@date_til.to_i)

            #create array for today's recipe data
		#run through recipe.meals 


            current_user.recipes.each do |recipe|
                  recipe.meals.each do |meal|

                        #select only food eaten today
                        if (@date_range.cover?(meal.time_eaten.to_i))
                        #push variables from recipe into array for food eaten today
                        @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name} 
                        end
                  end
            end




            #create array for today's item data
            #same thing for items -> run through item.meals
		@items.each do |item|
			item.meals.each do |meal|
                        #select items from today
      			if (@date_range.cover?(meal.time_eaten.to_i))
                        @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat, 'protein': meal.item.protein, 'carbs': meal.item.carbs, 'calories': meal.item.calories } 
                        end
			end
		end
            #test out elements
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#{@food_for_today}"

            #Repeat the same as above to specify morning (array with today's mornings recipes)
            #very undry!! Especially if we have to do this for all times
            #not working, no error just no data displayed -> meal seems to be nil
            @food_for_today_morning = []


# should be this: in if logic: @food_for_today['time_eaten']

            @items.each do |item|
                  item.meals.each do |meal|
                        if (meal.time_eaten.hour > Date.today.beginning_of_day.hour) &&
                              (meal.time_eaten.hour < Date.today.beginning_of_day.hour + 11.hours)
                              @food_for_today_morning << @food_for_today
                        end
                  end
            end
        


            #2015-05-13+00%3A00%3A00+-0700&%40date_till=2015-05-13+23%3A59%3A59+-0700
            


            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#{@frommer}#{@tiller}"









            #authorize
		if !user_signed_in?
			redirect_to '/users/sign_in'
		end
	end

end

            #   <% @user.recipes.each do |recipe| %>

            
            #  <% recipe.meals.each do |meal| %>
            # <% if (meal.time_eaten.day == @today.day) && 
            #       (meal.time_eaten.month == @today.month) %> 

            # <div style="margin: 15px;"> Recipe:
            #  <%= meal.recipe.name%>
            #  <%= meal.time_eaten%>
            #  <%= meal.time_eaten.day %>
            #  <%= meal.time_eaten.month %>
            #  </div>
            #  <%end%>
            #  <% end %>   
            #     <% end %> 
            


            # <% @items.each do |item| %>
            # <% item.meals.each do |meal| %>
            # <% if (meal.time_eaten.day == @today.day) && 
            #       (meal.time_eaten.month == @today.month) %> 
            # <div style="margin: 15px;"> Item: 
            #  <%= meal.item.name%>
            #  <%= meal.time_eaten%> 
            #               <%= meal.time_eaten.day %>
            #  <%= meal.time_eaten.month %>

