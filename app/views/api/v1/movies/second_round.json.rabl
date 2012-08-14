collection @movies
attributes :id, :name, :name_en, :poster_url
node(:record){ |movie| movie.find_friends_records @user.friends} if @user