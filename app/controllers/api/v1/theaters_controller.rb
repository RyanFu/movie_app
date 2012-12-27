class Api::V1::TheatersController < Api::ApiController
  def index
    if params[:area_id]
      @theaters = Theater.find_all_by_area_id(params[:area_id])
    else
      @theaters = Theater.all
    end
  end

  def get_movies_id
    movies_id = MovieTheaterShip.where(:theater_id => params[:id]).map{|m| m.movie_id}
    render :json => movies_id.to_json
  end

  def get_movies_id_and_hall_str
    movies = MovieTheaterShip.where(:theater_id => params[:id]).select("movie_id,hall_str")
    render :json => movies.to_json
  end
end
