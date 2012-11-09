class Api::V1::NewsController < ApplicationController
  def index

    if params[:page]
      @news = News.by_id_desc.paginate(:page => params[:page], :per_page => 20)
    else
      @news = News.by_id_desc
    end
  end
end
