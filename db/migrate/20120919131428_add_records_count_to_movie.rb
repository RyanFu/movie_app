class AddRecordsCountToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :records_count, :integer, :default => 0
    Movie.find_each do |movie|
      movie.update_attribute(:records_count, movie.records.length)
      movie.save
    end
  end
end
