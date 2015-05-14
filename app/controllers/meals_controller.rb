class MealsController < ApplicationController

	def create
		byebug
		time = meal_params['time_eaten'].split('T')
		year_mon_day = time[0].split('-')
		hour_min = time[1].split('%3A')

		date = Time.new(year_mon_day[0],year_mon_day[1],year_mon_day[2],hour_min[0],hour_min[1])



		@meal = Meal.new(meal_params)


		puts "\n\n\n\n\n\n\n\n\n\n THIS IS #{@meal.time_eaten}"
		puts "\n\n\n\n\n\n\n\n\n\n THAT IS #{@meal['time_eaten']}"
		puts "\n\n\n\n\n\n\n\n\n\n THEN IS #{@meal.recipe_id.nil?}"
		puts "\n\n\n\n\n\n\n\n\n\n WHAT IS #{@meal.item_id.nil?}"

		if (@meal.item_id.nil? && @meal.recipe_id.nil?)
			@meal.time_eaten = date
			if @meal.save
				item = Item.last
				meal = Meal.last
				item.meals << meal
				redirect_to :root
			end
		else 
				if @meal.save
					redirect_to :root
				end
		end
	end


	private

	  def meal_params
	    params.require(:meal).permit(:recipe_id, :item_id, :time_eaten)
	  end



end
