class UsersController < ApplicationController

before_filter :authenticate_user!

	def index
 		@feeds = Feed.all
 		@users = User.all
	end

	def show
    if (params[:id])
      @user = User.find(params[:id])
    else
		  @user = current_user
    end
      @users = @user.followed_users
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

  	def timeline
  		user = User.find(params[:id])
  		@articles = user.timeline_articles
  		render 'timeline'
  	end

end