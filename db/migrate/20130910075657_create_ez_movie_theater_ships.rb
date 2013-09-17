class CreateEzMovieTheaterShips < ActiveRecord::Migration
  def change
    create_table :ez_movie_theater_ships do |t|
      t.integer :movie_id	
      t.integer :theater_id
      t.integer :area_id
      t.string :movieez_id
      t.string :timetable
      t.string :hall_type
      t.string :hall_str
      t.timestamps
    end
    add_index :ez_movie_theater_ships, :movie_id
    add_index :ez_movie_theater_ships, :theater_id
    add_index :ez_movie_theater_ships, :area_id
  end
end
