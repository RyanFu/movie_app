class AddGoodCountsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :good_count, :integer
  end
end
