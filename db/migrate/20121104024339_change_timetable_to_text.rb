class ChangeTimetableToText < ActiveRecord::Migration
  def change
    change_column :movie_theater_ships, :timetable, :text
  end
end
