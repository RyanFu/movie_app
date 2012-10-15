class AddAreaIdToMovieTheaterShip < ActiveRecord::Migration
  def change
    add_column :movie_theater_ships, :area_id, :integer
    add_index :movie_theater_ships, :area_id
  end
end
