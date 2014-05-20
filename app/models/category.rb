class Category < ActiveRecord::Base
  attr_accessible :category_name, :user_id

  belongs_to :user
end
