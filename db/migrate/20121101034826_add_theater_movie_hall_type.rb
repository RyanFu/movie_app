class AddTheaterMovieHallType < ActiveRecord::Migration
  def change
    add_column :movie_theater_ships, :hall_type, :string
  end
end
