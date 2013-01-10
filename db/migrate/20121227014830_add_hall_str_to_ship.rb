class AddHallStrToShip < ActiveRecord::Migration
  def change
    add_column :movie_theater_ships, :hall_str, :string
  end
end
