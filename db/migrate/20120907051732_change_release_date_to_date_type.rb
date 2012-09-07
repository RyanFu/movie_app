class ChangeReleaseDateToDateType < ActiveRecord::Migration
  def up
    change_column :movies, :release_date, :date
  end

  def down
    change_column :movies, :release_date, :text
  end
end
