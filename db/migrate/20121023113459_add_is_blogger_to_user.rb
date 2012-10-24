class AddIsBloggerToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_blogger, :boolean, :default => false
  end
end
