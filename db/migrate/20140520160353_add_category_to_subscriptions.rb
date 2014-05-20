class AddCategoryToSubscriptions < ActiveRecord::Migration
  def up
    add_column :subscriptions, :category_id, :integer
  end


  def down
    remove_column :subscriptions, :category_id
  end
end
