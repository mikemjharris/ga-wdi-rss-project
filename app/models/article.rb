class Article < ActiveRecord::Base
  attr_accessible :author, :category, :content, :guid, :image, :published, :summary, :title, :url, :feed_id

  belongs_to :feed

  def self.create_from_feed_data(feed_data)

  	feed_data.entries.each do |article|

  	@article = Article.new()
  	@article.title = article.title
  	@article.summary = article.summary
  	@article.content = article.content
  	@article.author = article.author
  	@article.image = article.image
  	# @article.category = article.categories
  	@article.published = article.published
  	@article.url = article.url
  	@article.guid = article.entry_id
  	@article.save

  	end

  end

end
