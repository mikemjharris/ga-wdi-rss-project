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

      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.followed_users, owner_type: "User")

      b = []
      @activities.each do |activity|

          if activity.created_at.to_i > params[:since].to_i
              a = {}
              a["first_name"] = activity.owner.first_name 
              a["last_name"] = activity.owner.last_name
              a["id"] = activity.trackable.id 
              a["title"] = activity.trackable.title
              a["created"] = activity.created_at.to_i
              a["since"] = params[:since].to_i
              b << a 
          end
      end 
      
      respond_to do |format| 
        format.json {render json: b}
        format.html
      end
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