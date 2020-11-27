class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.integer :sending_user_id
      t.integer :receiving_user_id

      t.timestamps
    end
  end
end
