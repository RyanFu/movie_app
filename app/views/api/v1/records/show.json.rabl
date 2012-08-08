object @record
attributes :id, :comment, :score, :movie_id, :user_id

node(:created_at){ |record| record.created_at.strftime "%Y/%m/%d %H:%M" }
node(:user_name){ |record| record.user.name}
node(:user_fb_id){ |record| record.user.fb_id}
node(:movie){ |record|
  movie = record.movie
  m ={}
  m["name"] = movie.name
  m["name_en"] = movie.name_en
  m["release"] = Date.parse(movie.release_date).strftime "%Y/%m/%d"
  m["poster_url"] = movie.poster_url
  m["level_url"] = movie.level_url
  m["running_time"] = movie.running_time
  m
}
