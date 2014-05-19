class UsersController < ApplicationController

before_filter :authenticate_user!

	def index
 		@feeds = Feed.all
 		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		# @user = current_user
	end

	def following
	    @title = "Following"
	    @user = User.find(params[:id])
	    @users = @user.followed_users
	    render 'show_follow'
  	end

 	def followers
	    @title = "Followers"
	    @user = User.find(params[:id])
	    @users = @user.followers
	    render 'show_follow'
  	end

  	def favorites
  		user = current_user
  		@articles = user.favorite_articles
  		render 'favorites'
  	end

end