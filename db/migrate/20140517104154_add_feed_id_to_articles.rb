class AddFeedIdToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :feed_id, :integer
  end

  def down
  	remove_column :articles, :feed_id
  end
  
end
