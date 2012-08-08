object @record
attributes :id, :comment, :score, :movie_id, :user_id

node(:created_at){ |record| record.created_at.strftime "%Y/%m/%d %H:%M" }
node(:user_name){ |record| record.user.name}
node(:user_fb_id){ |record| record.user.fb_id}
node(:movie){ |record|
  record.movie
}
