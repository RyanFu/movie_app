class Api::V1::ChannelsController < ApplicationController
  def index
    @channels = Channel.all
  end

  def channel_time
    @channel_times = ChannelTime.find_all_by_channel_id(params[:id])
  end
end
