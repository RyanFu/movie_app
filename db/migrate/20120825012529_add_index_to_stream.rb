class AddIndexToStream < ActiveRecord::Migration
  def change
    add_index :streams, :record_id
    add_index :streams, :user_id
    add_index :streams, :comment_id
  end
end
