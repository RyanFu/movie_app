# encoding: UTF-8
class Api::V1::StreamsController < Api::ApiController
  def index
    user = User.find_by_fb_id(params[:fb_id])
    @streams = user.streams
  end
end
