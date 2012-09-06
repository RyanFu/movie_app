object @user
attributes :id, :name, :records_count, :fb_id
node(:friend_count) { |user| user.friends.size }