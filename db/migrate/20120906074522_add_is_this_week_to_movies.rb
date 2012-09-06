class AddIsThisWeekToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :is_this_week, :boolean, :default => false
  end
end
