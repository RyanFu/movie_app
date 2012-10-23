class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @records = Record.includes(:user).movie_record(@movie)
  end

  def index
    @hot_movies = MovieBoxOfficeShip.hot_movies
    @hot_movies_array = separate_array_by_num(@hot_movies,4)
    @first_round_movies = Movie.first_round.order("release_date DESC")
    @second_round_movies = Movie.second_round.order("release_date DESC")
    @comming_movies = Movie.comming
    @this_week_movies = Movie.this_week
  end


  private

  def separate_array_by_num (array_val,num)
    array_size = array_val.length / num +1;
    return_array = Array.new(array_size)
    i = 0
    array = Array.new
    array_val.each_with_index {|element, index|
        array << element
        i += 1
        if i%4 == 0
          return_array[i/num-1] = array
          array = Array.new
        end
    }
    return_array[array_size-1] = array
    return_array
  end
end
