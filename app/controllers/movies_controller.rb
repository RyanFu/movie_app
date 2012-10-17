class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @records = @movie.records
  end

  def index
    @hot_movies = MovieBoxOfficeShip.hot_movies
    @first_round_movies = Movie.first_round.order("release_date DESC")
    @second_round_movies = Movie.second_round.order("release_date DESC")
    @comming_movies = Movie.comming
    @this_week_movies = Movie.this_week
  end
end
