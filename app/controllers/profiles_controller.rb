class ProfilesController < ApplicationController

  def index
    @user = current_user
    @meal = Meal.new
    @recipe_options = current_user.recipes.map { |recipe| [recipe.name, recipe.id] }
    @item_options = current_user.items.map { |item| [item.name, item.id] }
    @items = current_user.items

    @today = Time.new

    @food_for_today = []

    @fat = 0
    @protein = 0
    @carbs = 0

    #run through recipe.meals
    current_user.recipes.each do |recipe|
    #run through each recipes items, 
      
      recipe.meals.each do |meal|
        if (meal.time_eaten.day == @today.day) && (meal.time_eaten.month == @today.month)
          @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.recipe.name} 
        
          meal.recipe.items.each do |item|
            @fat += item.fat
            @protein += item.protein
            @carbs += item.carbs
          end

        end
      end
    end

    @items.each do |item|

      item.meals.each do |meal|

        if (meal.time_eaten.day == @today.day) && (meal.time_eaten.month == @today.month)
          
          @food_for_today << {'time_eaten': meal.time_eaten, 'name': meal.item.name} 
        
          @fat += meal.item.fat
          @protein += meal.item.protein
          @carbs += meal.item.carbs

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
