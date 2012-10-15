class Api::V1::NewsController < ApplicationController
  def index
    @news = News.by_id_desc
  end
end
