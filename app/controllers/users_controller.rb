class UsersController < ApplicationController

before_filter :authenticate_user!

	def index
    @user = current_user
 		@users = User.all

    respond_to do |format|
        format.js  { render '/users/index.js.erb'}
        format.html { render '/users/index.js.erb'}
      end
	end

	def show
    if (params[:id])
      @user = User.find(params[:id])
    else
		  @user = current_user
    end
      @following = @user.followed_users

      @q = @user.followed_users.search(params[:q])
      @following = @q.result(:distinct => true)

      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.followed_users, owner_type: "User")
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