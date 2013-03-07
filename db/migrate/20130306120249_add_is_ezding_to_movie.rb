class AddIsEzdingToMovie < ActiveRecord::Migration
  def change
  	add_column :movies, :is_ezding, :boolean, :default => false
  end
end
