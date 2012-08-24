class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :record_id
      t.integer :comment_id
      t.integer :stream_type
      t.integer :user_id
      t.timestamps
    end
  end
end
