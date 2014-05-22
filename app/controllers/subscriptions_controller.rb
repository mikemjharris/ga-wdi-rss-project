class SubscriptionsController < ApplicationController

	def create
		@user = current_user
		@subscription = Subscription.new()
		@q = Feed.search(params[:q])
    
		
		if Feed.find_by_url(params[:feed_url])
			@feed = Feed.find_by_url(params[:feed_url])
			unless @user.feeds.include?(@feed)
				@subscription.feed_id = @feed.id
				@subscription.user_id = current_user.id
				@subscription.save
			else 
				flash[:alert] = "Already subscribed to that feed"
			end
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

		@feeds = Feed.all
		@subscriptions = @user.feeds

		respond_to do |format|
      format.js  {render 'create.js.erb'}
      format.html {redirect_to :root}
    end
	end


	def destroy
		Subscription.find(params[:id]).destroy

		respond_to do |format|
      format.js  {render "destroyed.js.erb"}
      format.html {redirect_to :root}
    end
		

	end



end