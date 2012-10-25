class Api::V1::MoviesController < Api::ApiController
  def index
    if params[:theater_id]
      @movies = Theater.find(params[:theater_id]).on_view_movies.order("release_date DESC")
      # @user = User.find_by_fb_id(params[:fb_id]) if params[:fb_id]
    else
      @movies = Movie.order("release_date DESC").all
    end
  end

  def first_round
    # @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @movies = Movie.first_round.order("release_date DESC")
  end

  def second_round
    # @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @movies = Movie.second_round.order("release_date DESC")
  end

  def comming
    @movies = Movie.comming
  end

  def hot
    @movies = MovieBoxOfficeShip.hot_movies
  end

  def this_week
    @movies = Movie.this_week
  end

  def show
    @movie = Movie.find(params[:id])
    @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @records = @movie.find_friends_records @user.friends if @user
  end

  def all
    @movies = Movie.all
  end

  def timetable
    movie = Movie.find(params[:id])
    if (params[:theater_id])
      @ships = MovieTheaterShip.where(:movie_id => movie.id, :theater_id => params[:theater_id])
    else
      @ships = MovieTheaterShip.includes(:theater,:area).find_all_by_movie_id(movie.id)
    end
  end

  def first_second_comming_hot
    movies = Movie.first_round_second_round_hot_comming
    render :json => movies.to_json
  end
end
