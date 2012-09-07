class Api::V1::MoviesController < Api::ApiController
  def index
    if params[:theater_id]
      @movies = Theater.find(params[:theater_id]).on_view_movies.order("id DESC")
      # @user = User.find_by_fb_id(params[:fb_id]) if params[:fb_id]
    else
      @movies = Movie.order("id DESC").all
    end
  end

  def first_round
    # @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @movies = Movie.first_round.order("id DESC")
  end

  def second_round
    # @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @movies = Movie.second_round.order("id DESC")
  end

  def hot
    @movies = MovieBoxOfficeShip.hot_movies
  end

  def show
    @movie = Movie.find(params[:id])
    @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @records = @movie.find_friends_records @user.friends if @user
  end

  def all
    @movies = Movie.all
  end
end
