class Article < ActiveRecord::Base
  attr_accessible :author, :category, :content, :guid, :image, :published, :summary, :title, :url, :feed_id

  belongs_to :feed

   markable_as :favorite

  def self.create_from_feed_data(feed_data, feed_id)
  	feed_data.entries.each do |article|
  	 create_article(article, feed_id)
  	end
  end

  def self.update_from_feed_data(feeds_data, feed_urls)

    feed_urls.each do |feed_url|
      feed_data = feeds_data[feed_url]
      feed_data.entries.each do |article|
        feed_id = Feed.where(url: feed_url).first.id
        if Article.where(guid: article.entry_id).empty?
          create_article(article, feed_id)
        end
      end

    end

  end


  def self.create_article(article, feed_id)
    @article = Article.new()
    @article.title = article.title
    @article.summary = article.summary
    @article.content = article.content
    @article.author = article.author
    @article.image = article.image
    @article.published = article.published
    @article.url = article.url
    @article.guid = article.entry_id
    @article.feed_id = feed_id     
    @article.save
  end


end
