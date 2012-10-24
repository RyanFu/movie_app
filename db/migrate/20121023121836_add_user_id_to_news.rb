class AddUserIdToNews < ActiveRecord::Migration
  def change
    add_column :news, :user_id, :integer
    add_index :news, :user_id
  end
end
