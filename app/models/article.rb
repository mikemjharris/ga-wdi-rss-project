class Article < ActiveRecord::Base
  include PublicActivity::Common
  
  attr_accessible :author, :category, :content, :guid, :image, :published, :summary, :title, :url, :feed_id

  belongs_to :feed

  scope :by_category, ->(category) { Article.joins(feed: {subscriptions: :category}).where(categories: {id: category.id})}
  scope :most_recent, order("published desc")


  markable_as :favorite, :timeline

  private

  def self.create_from_feed_data(feed_data, feed_id)
  	
    feed_data.entries.reverse.each do |article|
  	  create_article(article, feed_id)
  	end
  end

  def self.update_from_feed_data(feeds_data, feed_urls)

    feed_urls.each do |feed_url|
      feed_data = feeds_data[feed_url]
      feed_data.entries.reverse.each do |article|
        feed_id = Feed.where(url: feed_url).first.id
        if Article.where(guid: article.entry_id).empty?
          create_article(article, feed_id)
        end
      end

    end

  end


  def self.create_article(article, feed_id)
    
    @article = Article.create(title: article.title,
      summary: article.summary, content: article.content,
      author: article.author, published: article.published,
      url: article.url, guid: article.entry_id, feed_id: feed_id)
    begin
      @article.image = article.image
    rescue

    end
    @article.save

  end


end
