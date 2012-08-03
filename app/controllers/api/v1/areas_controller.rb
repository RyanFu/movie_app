class Api::V1::AreasController < Api::ApiController
  def index
    @areas = Area.all
  end
end
