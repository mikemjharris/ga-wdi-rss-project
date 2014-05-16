class Subscription < ActiveRecord::Base
  attr_accessible :feed_id, :private, :user_id
end
