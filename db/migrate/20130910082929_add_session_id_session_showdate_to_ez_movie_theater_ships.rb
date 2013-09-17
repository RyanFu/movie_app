class AddSessionIdSessionShowdateToEzMovieTheaterShips < ActiveRecord::Migration
  def change
  	add_column :ez_movie_theater_ships, :session_id, :string
  	add_column :ez_movie_theater_ships, :session_showdate, :date
  end
end
