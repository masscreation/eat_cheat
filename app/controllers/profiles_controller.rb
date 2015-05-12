class ProfilesController < ApplicationController

	def index
		@user = current_user
		@meal = Meal.new
		@recipe_options = Recipe.all.map { |recipe| [recipe.name, recipe.id] }
		@item_options = Item.all.map { |item| [item.name, item.id] }
		@items = Item.all

		@today = Time.new

		@food_for_today = []

		#run through recipe.meals
		current_user.recipes.each do |recipe|
			recipe.meals.each do |meal|
				if (meal.time_eaten.day == @today.day) && 
                  (meal.time_eaten.month == @today.month)
                 

                  @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name} 
              end
			end
		end

		@items.each do |item|
			item.meals.each do |meal|
				if (meal.time_eaten.day == @today.day) && 
                  (meal.time_eaten.month == @today.month)
                  @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.item.name} 
              end
			end
		end

		puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n #{@food_for_today}"




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
