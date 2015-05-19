class ProfilesController < ApplicationController
  before_filter :authenticate_user!

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
    @calories = 0

    #associate food with time_eaten:
  	@today = Time.new
  	@food_for_today = []
    @food_morning = []
    @food_midday = []
    @food_evening = []


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

      recipe.meals.each do |meal|
        
        meal.recipe.items.each do |item|

          #Filter info only for today
          if (meal.time_eaten.day == @today.day)

            #Filter info for Morning, Midday and Evening
            #MORNING:
            if (meal.time_eaten.hour.between?(0,11.5))

              #sum info for each recipe's items ->applestrudle: apple cal + flour cal

              #create array with all recipes eaten for morning
              @food_morning << { 'name': meal.recipe.name, 'calories': meal.recipe.cal_sum, 'carbs': meal.recipe.carb_sum, 
              'protein': meal.recipe.prot_sum, 'fat': meal.recipe.fat_sum}
            end

            # MIDDAY:
            if (meal.time_eaten.hour.between?(11.51,17.5))

              #create array with all recipes eaten for midday
              @food_midday << { 'name': meal.recipe.name, 'calories': meal.recipe.cal_sum, 'carbs': meal.recipe.carb_sum, 
              'protein': meal.recipe.prot_sum, 'fat': meal.recipe.fat_sum}
            end

            # EVENING:
            if (meal.time_eaten.hour.between?(17.51,23.99))
              @cal_per_recipe += item.calories.round(1)
              @carb_per_recipe += item.carbs.round(1)
              @prot_per_recipe += item.protein.round(1)
              @fat_per_recipe += item.fat.round(1)

              #create array with all recipes eaten for evening
              @food_evening << { 'name': meal.recipe.name, 'calories': @cal_per_recipe, 'carbs': @carb_per_recipe, 
              'protein': @prot_per_recipe, 'fat': @fat_per_recipe}
            end
            @calories += item.calories
          end #if filter today
            
          #connect recipe-data for charts
          meal.recipe.items.each do |item|
            @fat += item.fat
            @protein += item.protein
            @carbs += item.carbs
          end
        end #\item\
      end #\meal|
    end #|recipe|


    #create array for today's item data
    #same as for recipes -> run through item.meals
    @items.each do |item|
      item.meals.each do |meal|
        
        #Filter info only for today
        if (meal.time_eaten.day == @today.day)
          #select items only eaten today
          if (meal.time_eaten.hour.between?(0,11.5))
              @food_morning << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat.round(1), 'protein': meal.item.protein.round(1), 'carbs': meal.item.carbs.round(1), 'calories': meal.item.calories } 
          elsif (meal.time_eaten.hour.between?(11.6,17.5))
              @food_midday << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat.round(1), 'protein': meal.item.protein.round(1), 'carbs': meal.item.carbs.round(1), 'calories': meal.item.calories } 
          else (meal.time_eaten.hour.between?(17.6,23.9))
             @food_evening << {'time_eaten': meal.time_eaten, 'name': meal.item.name, 'fat': meal.item.fat.round(1), 'protein': meal.item.protein.round(1), 'carbs': meal.item.carbs.round(1), 'calories': meal.item.calories }            
          end
          @calories += meal.item.calories
        end #if filter today

            #connect recipe-data for charts
            @fat += meal.item.fat
            @protein += meal.item.protein
            @carbs += meal.item.carbs
      end #|item|
    end #|meal|

    #to display profile data
    @profile_array = []

    current_user.profiles.each do |data| 
        @profile_array << {'name': data.name, 'age': data.age, 'gender': data.gender, 'height': data.height, 'weight': data.weight, 'activity_level': data.activity_level}
    end

    #calculate caloric need
    #if no profile data then caloric need is 2000 else calculated as below
    @new_profile = current_user.profiles
    @data = @new_profile.last
    if @data != nil 
      if (@data.gender.to_i == 2)
          @cal_need = ((655 + (4.3 * @data.weight.to_i) + (4.7 * @data.height.to_i) - (4.7 * @data.age.to_i)) * @data.activity_level.to_i)
      elsif (@data.gender == 1)
          @cal_need = ((66 +(6.3 * @data.weight.to_i) + (12.9 * @data.height.to_i) - (6.8 * @data.age.to_i))  * @data.activity_level.to_i)
      end
    else  @cal_need = 2000
    end


    #authorize
    if !user_signed_in?
    redirect_to '/users/sign_in'
    end


end #end-index

def edit
  @user = current_user
  @profile = Profile.new
end

def new
  @user = current_user
  @profile = Profile.new
end

def create
  @profile = current_user.profiles.new(profile_params)
  @user = current_user
  
  if @profile.save
    redirect_to :root
  end
end

def show
  @user = current_user
  @profile = Profile.new
end

private
def profile_params
  params.require(:profile).permit(:name, :age, :gender, :height, :weight, :activity_level)
end

end #end-class


