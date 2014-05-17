class UsersController < ApplicationController

before_filter :authenticate_user!

	def index
		@feeds = Feed.all
	end

	def show
		user = current_user.id
		@subscriptions = Subscription.find(user)
	end

end