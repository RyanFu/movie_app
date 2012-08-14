class UserFriendShip < ActiveRecord::Base
  belongs_to :direct_friend, :foreign_key => "direct_friend_id",  :class_name => "User"
  belongs_to :inverse_friend,  :foreign_key => "inverse_friend_id",   :class_name => "User"
end
