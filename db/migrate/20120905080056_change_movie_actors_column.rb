class ChangeMovieActorsColumn < ActiveRecord::Migration
  def up
    change_column :movies, :actors, :text
    change_column :movies, :directors, :text
  end

  def down
    change_column :movies, :actors, :string
    change_column :movies, :directors, :string
  end
end
