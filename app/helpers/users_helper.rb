module UsersHelper
  def user_avatar fb_id
    "http://graph.facebook.com/#{fb_id}/picture?type=square"
  end
end
