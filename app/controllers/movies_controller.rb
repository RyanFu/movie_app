class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @records = @movie.records
  end
end
