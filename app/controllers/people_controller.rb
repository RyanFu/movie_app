class PeopleController < ApplicationController

  def index
    @people = User.limit(3)
    @user = User.first
    @streams = Stream.includes(:record,:comment,:movie,:stream_user).user_streams(@user).by_id
  end

  def show 
  end
end
