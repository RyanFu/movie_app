object @movie
attributes :id, :name, :name_en, :intro, :poster_url, :running_time, :level_url, :actors, :directors, :youtube_video_id

node(:release) { |movie| Date.parse(movie.release_date).strftime "%Y/%m/%d" if movie.release_date}
node(:record){ |movie| @records } if @user