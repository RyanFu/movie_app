class ChangeGoodCountDefaultValue < ActiveRecord::Migration
  def up
    change_column :movies, :good_count, :integer, :default => 0
  end

  def down
    change_column :movies, :good_count, :integer
  end
end
