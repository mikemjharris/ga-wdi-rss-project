class SubscriptionsController < ApplicationController

	def create
		@subscription = Subscription.new()
		if Feed.find_by_url(params[:feed_url])
			@subscription.feed_id = Feed.find_by_url(params[:feed_url]).id
		else
			@feed_data = Feedjira::Feed.fetch_and_parse("#{params[:feed_url]}")
			@feed = Feed.new(url: params[:feed_url])
			@feed.title = @feed_data.title
			@feed.description = @feed_data.description
			@feed.save
			@subscription.feed_id = @feed.id
		end

		@subscription.user_id = current_user.id
		@subscription.save
		redirect_to :root
	end

end