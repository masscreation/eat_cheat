class MealsController < ApplicationController

	def create
		@meal = Meal.new(meal_params)

		if (@meal.item_id.nil? && @meal.recipe_id.nil?)
			item = Item.last
			
			time = meal_params['time_eaten'].split('T')
			year_mon_day = time[0].split('-')
			hour_min = time[1].split('%3A')
			date = Time.new(year_mon_day[0],year_mon_day[1],year_mon_day[2],hour_min[0],hour_min[1])

			@meal.time_eaten = date

			if @meal.save
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
