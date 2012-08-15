collection @records
attributes :id, :comment, :score, :movie_id, :user_id

node(:created_at){ |record| record.created_at.strftime "%Y/%m/%d %H:%M" }
node(:user_name){ |record| @user.name}
node(:user_fb_id){ |record| @user.fb_id}
node(:movie){ |record|
  movie = record.movie
  m ={}
  m["name"] = movie.name
  m["poster_url"] = movie.poster_url
  m
}
