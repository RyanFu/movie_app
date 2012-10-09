class AddTimeColumnToMovieTheaterShip < ActiveRecord::Migration
  def change
    add_column :movie_theater_ships, :timetable, :string
  end
end
