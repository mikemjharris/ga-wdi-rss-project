class FeedsController < ApplicationController

	def create
	end

  def destroy
      Feed.find(params[:id]).articles.destroy
      Feed.find(params[:id]).destroy
      redirect_to :root

  end

end
