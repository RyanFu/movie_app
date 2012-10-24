class PeopleController < ApplicationController

  def index
    @top_users = User.top_user
    @top_users_array = separate_array_by_num(@top_users,4)
    @user = User.first
    @streams = Stream.includes(:record,:comment,:movie,:stream_user).user_streams(@user).by_id
  end

  def show 
  end
end
