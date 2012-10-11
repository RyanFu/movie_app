class Api::V1::NewsController < ApplicationController
  def index
    @news = News.all
  end
end
