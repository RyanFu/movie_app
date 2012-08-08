object @movie
attributes :id, :name, :name_en, :intro, :poster_url, :running_time, :level_url, :actors, :directors

node(:release) { |movie| Date.parse(movie.release_date).strftime "%Y/%m/%d" }
node(:record){ |movie| movie.find_friends_records @user.facebook_friends_use_app} if @user