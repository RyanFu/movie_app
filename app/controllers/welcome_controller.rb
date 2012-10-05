class WelcomeController < ApplicationController
  def index
    @movies = Movie.limit(8)
  end
end
