collection @records
attributes :id, :comment, :score, :movie_id, :user_id, :created_at

node(:user_name){ |record| record.user.name}
node(:movie){ |record|
  movie = record.movie
  m ={}
  m["name"] = movie.name
  m["poster_url"] = movie.poster_url
  m
}
