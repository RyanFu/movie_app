object @user
attributes :id, :name, :records_count
node(:friend_count) { |user| user.friends.size }