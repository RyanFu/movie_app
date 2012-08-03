class AddIsHotToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :is_hot, :boolean, :default => false
  end
end
