collection @movies
attributes :id, :name, :name_en, :intro, :poster_url, :running_time, :level_url, :actors, :directors, :youtube_video_id

node(:release) { |movie| Date.parse(movie.release_date).strftime "%Y/%m/%d" }
node(:record){ |movie| movie.find_friends_records @user.friends} if @user