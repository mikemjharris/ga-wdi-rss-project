# namespace :update_articles do

desc "update_articles in the database"
task :update_all_articles => :environment do
    feed_urls = Feed.all.map{|feed| feed.url}
    feed_data = Feedjira::Feed.fetch_and_parse(feed_urls)
    
    if feed_data != 0
      Article.update_from_feed_data(feed_data, feed_urls)
    end
end

  
# end
