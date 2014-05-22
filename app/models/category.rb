class Category < ActiveRecord::Base
  attr_accessible :category_name, :user_id

  belongs_to :user
  has_many :subscriptions
  has_many :feeds
  # has_many :articles, :through => :subscriptions, :through => :feeds

  def cover_image
    article = Article.by_category(self) 
  	unless article.blank?
			article.last.image if article.last.image
    end
  end

end
