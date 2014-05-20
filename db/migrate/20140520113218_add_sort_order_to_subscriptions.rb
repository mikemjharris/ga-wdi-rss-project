class AddSortOrderToSubscriptions < ActiveRecord::Migration
  def up
    add_column :subscriptions, :sort_order, :integer
  end


  def down
    remove_column :subscriptions, :sort_order
  end

end
