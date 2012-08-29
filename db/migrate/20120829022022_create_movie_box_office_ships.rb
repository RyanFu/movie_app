class CreateMovieBoxOfficeShips < ActiveRecord::Migration
  def change
    create_table :movie_box_office_ships do |t|
      t.integer :movie_id

      t.timestamps
    end
    add_index  :movie_box_office_ships, :movie_id
  end
end
