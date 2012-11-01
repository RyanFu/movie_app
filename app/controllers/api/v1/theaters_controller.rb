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
end
