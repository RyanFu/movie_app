class NewsController < ApplicationController
  
  def index
    @bloggers = User.limit(3)
  end

end
