class Article < ActiveRecord::Base
  attr_accessible :author, :category, :content, :guid, :image, :published, :summary, :title, :url

  belongs_to :feed

  def self.create_from_feed_data(feed_data)

  	feed_data.entries.each do |article|

  	@article = Article.new()
  	@article.title = article.title
  	@article.save
  	
  	end

  end

end
