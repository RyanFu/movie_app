class AddStreamMovieIdStreamUserIdToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :stream_user_id, :integer
    add_column :streams, :movie_id, :integer
    add_index :streams, :stream_user_id
    add_index :streams, :movie_id
  end
end
