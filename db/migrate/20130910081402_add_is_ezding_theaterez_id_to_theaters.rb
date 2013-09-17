class AddIsEzdingTheaterezIdToTheaters < ActiveRecord::Migration
  def change
  	add_column :theaters, :theaterez_id, :string
  	add_column :theaters, :is_ezding, :boolean, :default => false
  end
end
