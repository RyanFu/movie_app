class AddRecordCountToUser < ActiveRecord::Migration
  def up
    add_column :users, :records_count, :integer, :default => 0
    User.find_each do |user|
      user.update_attribute(:records_count, user.records.length)
      user.save
    end
  end
  def down
    remove_column :users, :records_count
  end
end
