class FeedsController < ApplicationController

	def create
		@feed = Feed.new(params[:feed_url])
		@feed.save
	end

end
