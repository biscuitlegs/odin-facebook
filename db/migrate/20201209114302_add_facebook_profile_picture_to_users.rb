class AddFacebookProfilePictureToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :facebook_profile_picture, :string
  end
end
