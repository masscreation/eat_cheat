class MealsController < ApplicationController

	def create
		@meal = Meal.new(meal_params)
		puts "\n\n\n\n\n\n\n\n\n\n #{@meal}"
		if @meal.save
		redirect_to :root
		end
	end


	private

	  def meal_params
	    params.require(:meal).permit(:recipe_id, :item_id, :time_eaten)
	  end



end
