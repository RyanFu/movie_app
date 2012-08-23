class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :record_id
      t.integer :user_id
      t.string  :text

      t.timestamps
    end
    add_index :comments, :record_id
    add_index :comments, :user_id
  end
end
