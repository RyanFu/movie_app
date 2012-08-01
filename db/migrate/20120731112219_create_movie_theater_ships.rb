class CreateMovieTheaterShips < ActiveRecord::Migration
  def change
    create_table :movie_theater_ships do |t|
      t.integer :movie_id
      t.integer :theater_id
      t.timestamps
    end
    add_index :movie_theater_ships, :movie_id
    add_index :movie_theater_ships, :theater_id
  end
end
