class NewsController < ApplicationController
  
  def index
    @bloggers = User.blogger
    @news = News.all
  end

  def show
    @news = News.find(params[:id])
    @user = @news.user

    @news = News.first
    @user = User.first
  end

end
