class AddProfilePictureImageToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :profile_picture
    add_column :users, :profile_picture_image, :string
  end

  def down
    add_column :users, :profile_picture, :string
    remove_column :users, :profile_picture_image
  end
end
