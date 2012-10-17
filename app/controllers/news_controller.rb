class NewsController < ApplicationController
  
  def index
    @bloggers = User.limit(3)
    @news = News.all
  end

  def show
    @news = News.find(params[:id])
  end

end
