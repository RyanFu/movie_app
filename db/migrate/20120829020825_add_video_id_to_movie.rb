class AddVideoIdToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :youtube_video_id, :string
    add_index  :movies, :youtube_video_id
  end
end
