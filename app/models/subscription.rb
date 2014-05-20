class Subscription < ActiveRecord::Base
  attr_accessible :feed_id, :private, :user_id

  belongs_to :user
  belongs_to :feed

  has_many :categories
end
