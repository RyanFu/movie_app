collection @streams
attributes :stream_type

node(:stream){ |stream|
  if (stream.stream_type == 1)
    child(:record,:include => [:user]) do
    	attributes :id, :comment, :score, :movie_id, :user_id

      node(:created_at){ |record| record.updated_at.strftime "%Y/%m/%d %H:%M" }
      node(:user_name){ |record| record.user.name}
      node(:user_fb_id){ |record| record.user.fb_id}
      node(:movie){ |record|
        movie = record.movie
        m ={}
        m["name"] = movie.name
        m["name_en"] = movie.name_en
        m["release"] = Date.parse(movie.release_date).strftime "%Y/%m/%d" if movie.release_date
        m["poster_url"] = movie.poster_url
        m["level_url"] = movie.level_url
        m["running_time"] = movie.running_time
        m
      }
    end
  else
    child(:comment) do
      attributes :id, :user_id, :text
      node(:user_fb_id){|comment| comment.user.fb_id}
      node(:user_name){|comment| comment.user.name}
      node(:record_id){|comment| comment.record.id}
      node(:created_at){ |comment| comment.updated_at.strftime "%Y/%m/%d %H:%M" }
      node(:movie_name){ |comment| comment.record.movie.name }
    end
  end
  {}
}