object @record
attributes :id, :comment, :score, :movie_id, :user_id, :created_at

node(:user_name){ |record| record.user.name}
node(:user_fb_id){ |record| record.user.fb_id}
node(:movie){ |record|
  record.movie
}
