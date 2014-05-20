module SubscriptionHelper

  def find_subscription(feed, user)
    Subscription.where("feed_id = #{feed.id} and user_id = #{user.id}").first
  end  

end
