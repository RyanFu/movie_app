collection @records
attributes :id, :comment, :score, :movie_id, :user_id, :comments_count, :love_count

node(:is_loved_by_user){|record| (@user.love_records.include? record)} if @user
node(:created_at){ |record| record.created_at.strftime "%Y/%m/%d %H:%M" }
node(:user_name){ |record| record.user.name}
node(:user_fb_id){ |record| record.user.fb_id}
node(:movie){ |record|
  m ={}
  m["name"] = @movie.name
  m["poster_url"] = @movie.poster_url
  m
}
