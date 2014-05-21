class TimelinesController < ApplicationController

	def create
		user = current_user
		@article = Article.find(params[:id])
		user.mark_as_timeline [ @article ]
		@article.create_activity :create, owner: current_user

		respond_to do |format|
    		format.js {render '/articles/timeline.js.erb'}
    		format.html { redirect_to :back }

   		end	
		
	end

	def destroy
		user = current_user
		@article = Article.find(params[:id])
		user.remove_mark :timeline, [ @article ]
		
		respond_to do |format|
    		format.js {render '/articles/timeline.js.erb'}
    		format.html { redirect_to :back }

   		end	
	end

	def show
		@user = User.find(params[:id])
		@articles = @user.timeline_articles

		respond_to do |format|
	      format.js  { render '/users/timeline.js.erb'}
	      format.html { render '/users/timeline.js.erb'}
	    end
	end

end