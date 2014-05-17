class SubscriptionsController < ApplicationController

	def create
		@user = current_user
		@subscription = Subscription.new()
		
		if Feed.find_by_url(params[:feed_url])
			@subscription.feed_id = Feed.find_by_url(params[:feed_url]).id
		else
			feed_data = Feedjira::Feed.fetch_and_parse("#{params[:feed_url]}")
			if feed_data != 0	

				
				@feed = Feed.new(url: params[:feed_url])
				@feed.title = feed_data.title
				@feed.description = feed_data.description
				@feed.save
				@subscription.feed_id = @feed.id
				@subscription.user_id = current_user.id
				@subscription.save
				Article.create_from_feed_data(feed_data, @feed.id)
			else 
				flash[:alert] = "Not a valid rss feed"
			end
		end

		

		redirect_to :root
	end

end