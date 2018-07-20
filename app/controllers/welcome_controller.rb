class WelcomeController < ApplicationController
	def home
		redirect_to current_user if logged_in?
		@user = User.new
	end
end
