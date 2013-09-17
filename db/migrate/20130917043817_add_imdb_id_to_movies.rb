class AddImdbIdToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :imdb_id, :integer, :default => 0
  end
end
