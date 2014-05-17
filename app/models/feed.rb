class Feed < ActiveRecord::Base
  attr_accessible :description, :title, :url

  has_many :articles
  has_many :subscriptions
  has_many :users, :through => :subscriptions

end
