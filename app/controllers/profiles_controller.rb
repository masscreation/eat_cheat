class ProfilesController < ApplicationController

	def index
		@user = current_user
		@meal = Meal.new
		@recipe_options = Recipe.all.map { |recipe| [recipe.name, recipe.id] }
		@item_options = Item.all.map { |item| [item.name, item.id] }


		if !user_signed_in?
			redirect_to '/users/sign_in'
		end
		#display form (toggle) for meals

		#edit in 


	end

end
