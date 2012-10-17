class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @records = @user.records.by_created
  end
end
