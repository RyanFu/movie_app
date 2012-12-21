# encoding: UTF-8
class Api::V1::RecordsController < Api::ApiController
  protect_from_forgery :except => [:create, :love]

  def create
    record = Record.new
    record.score = params[:score]
    record.comment = params[:comment]
    record.movie_id = params[:movie_id]
    record.user = User.find_by_fb_id(params[:fb_id])

    if record.save
      logger.info("params message: #{params.to_json}")
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("params message: #{params.to_json}")
      logger.info("error message: #{record.errors.messages}")
      render :status=>401, :json=>{:message=> "record create fail" }
    end
  end

  def update
    @record = Record.find(params[:id])

    @record.score = params[:score]
    @record.comment = params[:comment]

    if @record.save
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{@record.errors.messages}")
      render :status=>401, :json=>{:message=> "update fail" }
    end

  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    render :status=>200, :json=>{:message=> "destroy success" }
  end

  def index
    if params[:movie_id]
      movie = Movie.find(params[:movie_id])
      @user = User.find_by_fb_id(params[:fb_id])
      @records = movie.find_friends_origin_records(@user.friends)
    else
      @user = User.find_by_fb_id(params[:fb_id])
      @records = Record.includes(:movie).records_by_user(@user)
    end
  end

  def records_with_page
    @user = User.find_by_fb_id(params[:fb_id])
    @records = Record.includes(:movie).records_by_user(@user).by_created.paginate(:page => params[:page], :per_page => 9)
    render :action => :index
  end

  def get_movie_records
    @movie = Movie.find(params[:movie_id])
    @records = Record.includes(:user).movie_record(@movie)
    @user = User.find_by_fb_id(params[:fb_id]) if params[:fb_id]
  end

  def get_movie_records_limit
    @movie = Movie.find(params[:movie_id])
    @records = Record.includes(:user).movie_record_comment(@movie).by_love_count.limit(5)
    @user = User.find_by_fb_id(params[:fb_id]) if params[:fb_id]
  end

  def show
    @user = User.find_by_fb_id(params[:fb_id]) if params[:fb_id]
    @record = Record.includes(:user).find(params[:id])
  end

  def friend_stream
    @user = User.find_by_fb_id(params[:fb_id])
    @records = Record.friend_records(@user).by_created.includes(:user)
  end

  def love
    user = User.find_by_fb_id(params[:fb_id])
    record = Record.find(params[:id])
    love_records = user.love_records
    if love_records.include? record
      render :status=>403, :json=>{:message => "already loved"}
    else
      user.love_records << record
      render :status=>200, :json=>{:message => "success"}
    end
  end

  def unlove
    user = User.find_by_fb_id(params[:fb_id])
    record = Record.find(params[:id])
    user.love_records.destroy record
    render :status=>200, :json=>{:message => "success"}
  end
end
