# encoding: UTF-8
class Api::V1::StreamsController < Api::ApiController
  def index
    @user = User.find_by_fb_id(params[:fb_id])
    @streams = Stream.includes(:record,:comment,:movie,:stream_user).user_streams(@user).by_id
    @love_records = @user.love_records.map{|r| r.id}
    output = []
    @streams.each do |stream|
      r = {}
      r["stream_type"] = stream.stream_type
      if stream.stream_type == 1
        record = stream.record
        # record = Record.includes(:movie,:user).find(stream.record_id)
        user = stream.stream_user
        movie = stream.movie
        r["record"] = {}
        r["record"]["id"] = record.id
        r["record"]["comment"] = record.comment
        r["record"]["score"] = record.score
        r["record"]["movie_id"] = movie.id
        r["record"]["comments_count"] = record.comments_count
        r["record"]["love_count"] = record.love_count
        r["record"]["is_loved_by_user"] = (@love_records.include? record.id)
        r["record"]["created_at"] = record.updated_at.strftime "%Y/%m/%d %H:%M"
        r["record"]["user_name"] = user.name
        r["record"]["user_fb_id"] = user.fb_id
        r["record"]["movie"] = {}
        r["record"]["movie"]["name"] = movie.name
        r["record"]["movie"]["name_en"] = movie.name_en
        r["record"]["movie"]["release"] = movie.release_date.strftime "%Y/%m/%d" if movie.release_date
        r["record"]["movie"]["poster_url"] = movie.poster_url
        r["record"]["movie"]["level_url"] = movie.level_url
        r["record"]["movie"]["running_time"] = movie.running_time
        s = {"stream" => r}
        output << s 
      elsif  stream.stream_type == 2
        comment = stream.comment
        # comment = Comment.includes(:record,:user).find(stream.comment_id)
        user = stream.stream_user
        r["comment"] = {}
        r["comment"]["id"] = comment.id
        r["comment"]["user_id"] = user.id
        r["comment"]["text"] = comment.text
        r["comment"]["user_fb_id"] = user.fb_id
        r["comment"]["user_name"] = user.name
        r["comment"]["record_id"] = comment.record_id
        r["comment"]["created_at"] = comment.updated_at.strftime "%Y/%m/%d %H:%M"
        r["comment"]["movie_name"] = stream.movie.name
        s = {"stream" => r}
        output << s 

      end
        

    end
    render :json => output.to_json
  end

  def streams_with_page
    @user = User.find_by_fb_id(params[:fb_id])
    @streams = Stream.includes(:record,:comment,:movie,:stream_user).user_streams(@user).by_id.paginate(:page => params[:page], :per_page => 10)
    @love_records = @user.love_records.map{|r| r.id}
    output = []
    @streams.each do |stream|
      r = {}
      r["stream_type"] = stream.stream_type
      if stream.stream_type == 1
        record = stream.record
        # record = Record.includes(:movie,:user).find(stream.record_id)
        user = stream.stream_user
        movie = stream.movie
        r["record"] = {}
        r["record"]["id"] = record.id
        r["record"]["comment"] = record.comment
        r["record"]["score"] = record.score
        r["record"]["movie_id"] = movie.id
        r["record"]["comments_count"] = record.comments_count
        r["record"]["love_count"] = record.love_count
        r["record"]["is_loved_by_user"] = (@love_records.include? record.id)
        r["record"]["created_at"] = record.updated_at.strftime "%Y/%m/%d %H:%M"
        r["record"]["user_name"] = user.name
        r["record"]["user_fb_id"] = user.fb_id
        r["record"]["movie"] = {}
        r["record"]["movie"]["name"] = movie.name
        r["record"]["movie"]["name_en"] = movie.name_en
        r["record"]["movie"]["release"] = movie.release_date.strftime "%Y/%m/%d" if movie.release_date
        r["record"]["movie"]["poster_url"] = movie.poster_url
        r["record"]["movie"]["level_url"] = movie.level_url
        r["record"]["movie"]["running_time"] = movie.running_time
        s = {"stream" => r}
        output << s 
      elsif  stream.stream_type == 2
        comment = stream.comment
        # comment = Comment.includes(:record,:user).find(stream.comment_id)
        user = stream.stream_user
        r["comment"] = {}
        r["comment"]["id"] = comment.id
        r["comment"]["user_id"] = user.id
        r["comment"]["text"] = comment.text
        r["comment"]["user_fb_id"] = user.fb_id
        r["comment"]["user_name"] = user.name
        r["comment"]["record_id"] = comment.record_id
        r["comment"]["created_at"] = comment.updated_at.strftime "%Y/%m/%d %H:%M"
        r["comment"]["movie_name"] = stream.movie.name
        s = {"stream" => r}
        output << s 

      end
        

    end
    render :json => output.to_json
  end
end
