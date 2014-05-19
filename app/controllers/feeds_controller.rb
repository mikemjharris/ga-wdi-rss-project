class FeedsController < ApplicationController

	def create
	end

  def destroy
      # Feed.find(params[:id]).articles.destroy
      Feed.find(params[:id]).destroy
      redirect_to :root
  end

  def update_articles
    if (params[:id])
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    feed_urls = Feed.all.map{|feed| feed.url}
    feed_data = Feedjira::Feed.fetch_and_parse(feed_urls)
    
    if feed_data != 0
      Article.update_from_feed_data(feed_data, feed_urls)
    end
     

    respond_to do |format|
      
      format.json {render json: feed_data}
      format.js  { render 'update_articles.js.erb'}
      format.html {redirect_to :root }
      
    end

  end

  def show
    @feed = Feed.find(params[:id])

    respond_to do |format|
      
      format.js  { render 'show.js.erb'}
      format.html
      
    end
  end



end
