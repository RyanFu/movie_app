class UsersController < ApplicationController
  def show
    redirect_to :action => :records
  end

  def records
    @user = User.find(params[:id])
    @records = @user.records.by_created
  end

  def following
    @user = User.find(params[:id])
    @followings = @user.inverse_friends
  end

  def follower
    @user = User.find(params[:id])
    @followers = @user.direct_friends
  end
end
