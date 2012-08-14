class CreateUserFriendShips < ActiveRecord::Migration
  def change
    create_table :user_friend_ships do |t|
      t.integer :direct_friend_id
      t.integer :inverse_friend_id

      t.timestamps
    end
    add_index :user_friend_ships, :direct_friend_id
    add_index :user_friend_ships, :inverse_friend_id
  end
end
