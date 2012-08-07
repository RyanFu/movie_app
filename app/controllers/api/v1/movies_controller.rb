class Api::V1::MoviesController < Api::ApiController
  def index
    if params[:theater_id]
      @movies = Theater.find(params[:theater_id]).on_view_movies.includes(:records)
      @user = User.find_by_fb_id(params[:fb_id]) if params[:fb_id]
    else
      @movies = Movie.all
    end
  end

  def first_round
    @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @movies = Movie.first_round.includes(:records)
  end

  def second_round
    @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
    @movies = Movie.second_round.includes(:records)
  end

  def hot
    @movies = Movie.hot
  end

  def show
    @movie = Movie.includes(:records).find(params[:id])
    @user = User.find_by_fb_id(params[:fb_id])  if params[:fb_id]
  end
end
