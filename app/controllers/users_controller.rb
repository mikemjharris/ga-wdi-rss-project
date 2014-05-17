class UsersController < ApplicationController

before_filter :authenticate_user!

	def index
		@feeds = Feed.all
	end

	def show
		@user = User.find(current_user.id)
	end

end