class CreateUserLoveRecordShips < ActiveRecord::Migration
  def change
    create_table :user_love_record_ships do |t|
      t.integer :user_id
      t.integer :record_id

      t.timestamps
    end
    add_index :user_love_record_ships, :user_id
    add_index :user_love_record_ships, :record_id
  end
end
