class AddIsCommingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :is_comming, :boolean, :default => false
  end
end
