class TimelinesController < ApplicationController

	def create
		user = current_user
		@article = Article.find(params[:id])
		user.mark_as_timeline [ @article ]

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

end