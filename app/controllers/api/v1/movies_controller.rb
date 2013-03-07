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
    movies = Movie.first_round_second_round_hot_comming_this_week
    render :json => movies.to_json
  end

  def first_second_comming_hot_update
    @movies_first = Movie.select('id').first_round
    @movies_second = Movie.select('id').second_round
    @movies_commig = Movie.select('id').comming
    @movies_hot = Movie.select('id').hot
    @movies_this_week = Movie.select('id').this_week
    return_object = {}
    return_object["first_round"] = @movies_first
    return_object["movies_second"] = @movies_second
    return_object["movies_commig"] = @movies_commig
    
    ids = MovieBoxOfficeShip.all.map{|m| m.movie_id}
    object = Array.new(ids.size)
    (0..ids.size-1).each do |i|
      object[i-1] = {:id => ids[i-1]}
    end

    return_object["movies_hot"] = object

    return_object["movies_this_week"] = @movies_this_week
    # return_object["new_movie"] = Movie.where(["created_at > ?",Time.parse("2012/10/13")])
    render :json => return_object.to_json
  end

  def movies_info
    movies_id = params[:movies_id]
    movies_id_array = movies_id.split(",")
    @movies = Movie.select('id,name,name_en,intro,poster_url,release_date,running_time,level_url,actors,actors,is_first_round,is_second_round,is_hot,youtube_video_id,is_comming,is_this_week').where(['id in (?)', movies_id_array])
    render :json => @movies.to_json
  end

  def movie_info
    movie_id = params[:id]
    @movie = Movie.select('release_date,running_time,youtube_video_id,level_url,is_ezding').find(movie_id)
    render :json => @movie.to_json
  end

  def update_release_date_running_time_youtube
    movie = Movie.select('release_date,running_time,youtube_video_id,level_url').find(params[:id])
    render :json => movie.to_json
  end
end
