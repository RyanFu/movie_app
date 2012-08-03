class Api::V1::TheatersController < Api::ApiController
  def index
    if params[:area_id]
      @theaters = Theater.find_all_by_area_id(params[:area_id])
    else
      @theaters = Theater.all
    end
  end
end
