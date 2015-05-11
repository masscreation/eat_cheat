class ProfilesController < ApplicationController

	def index
		@user = current_user
		if !user_signed_in?
			redirect_to '/users/sign_in'
		end
	end
end
