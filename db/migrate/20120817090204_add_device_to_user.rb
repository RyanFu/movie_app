class AddDeviceToUser < ActiveRecord::Migration
  def change
    add_column :users, :device_id, :integer
    add_column :users, :registration_id, :string
    add_index :users, :device_id
  end
end
