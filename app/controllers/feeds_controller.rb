class FeedsController < ApplicationController

	def create
		@feed_data = Feedjira::Feed.fetch_and_parse("#{params[:feed_url]}")
		@feed = Feed.new(url: params[:feed_url])
		@feed.title = @feed_data.title
		@feed.description = @feed_data.description
		@feed.save
		redirect_to :root
	end

end
