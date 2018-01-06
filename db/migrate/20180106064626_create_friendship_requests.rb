class CreateFriendshipRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :friendship_requests do |t|
      t.integer :request_flag
      t.integer :send_user_id
      t.integer :get_user_id

      t.timestamps  null: false
    end
  end
end
