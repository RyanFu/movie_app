class ChangeImdbRatingTypeValue < ActiveRecord::Migration
  def up
  	change_column :movies, :imdb_rating, :string
  end

  def down
  	change_column :movies, :imdb_rating, :integer
  end
end
