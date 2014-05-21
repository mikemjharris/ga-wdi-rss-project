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

  def index

    # if params[:q].nil?
      @q = Feed.search(params[:q])
      @feeds = @q.result(:distinct => true)
    # else  
      # @feeds = Feed.all
    # end

    @subscriptions = current_user.feeds
    respond_to do |format|
      format.js  { render 'index.js.erb'}
      format.html
    end

  end

  def sortable
    @user = current_user
    @new_order = params["feed"]
    a = current_user
    c = ""
    category_id = nil
    @new_order.each.with_index do |feed_id, i|
            c = @user.subscriptions.where(:feed_id => feed_id.to_i).first
          unless c.nil?   
            c.sort_order = i
            c.category_id = category_id
            c.save
        else
            category_id = feed_id[10..-1].to_i
        end
    end  

    respond_to do |format|
      format.json  { render json: current_user}
    end
  end

  def middle
    @partial = params["partial"]
    respond_to do |format|
      format.js  { render "categories/categorysort.js.erb"}
    end

  end

end
