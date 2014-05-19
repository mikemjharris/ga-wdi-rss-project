class TimelinesController < ApplicationController

	def create
		user = current_user
		article = Article.find(params[:id])
		user.mark_as_timeline [ article ]
		redirect_to :back
	end

	def destroy
		user = current_user
		article = Article.find(params[:id])
		user.remove_mark :timeline, [ article ]
		redirect_to :back
	end

end