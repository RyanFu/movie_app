class AddIsTopUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_top_user, :boolean, :default => false
  end
end
