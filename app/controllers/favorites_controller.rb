class FavoritesController < ApplicationController

	def create
		user = current_user
		@article = Article.find(params[:id])
		user.mark_as_favorite [ @article ]

		respond_to do |format|
    		format.js {render '/articles/favorite.js.erb'}
    		format.html { redirect_to :back }

   		end	
	end

	def destroy
		user = current_user
		@article = Article.find(params[:id])
		user.remove_mark :favorite, [ @article ]
		respond_to do |format|
    		format.js {render '/articles/favorite.js.erb'}
    		format.html { redirect_to :back }
   		end	
	end

end