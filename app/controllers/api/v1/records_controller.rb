# encoding: UTF-8
class Api::V1::RecordsController < Api::ApiController
  protect_from_forgery :except => :create
  
  def create
    recordJson = JSON.parse(params[:record])
    record = Record.new(recordJson)
    record.user = User.find_by_fb_id(params[:fb_id])

    if record.save
      logger.info("params message: #{params.to_json}")
      logger.info("recordJson message: #{recordJson.to_json}")
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("params message: #{params.to_json}")
      logger.info("error message: #{record.errors.messages}")
      render :status=>401, :json=>{:message=> "record create fail" }
    end
  end

  def update
    @record = Record.find(params[:id])

    if @record.update_attributes(params[:record])
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{@record.errors.messages}")
      render :status=>401, :json=>{:message=> "update fail" }
    end

  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    render :status=>401, :json=>{:message=> "destroy success" }
  end

  def index
    if params[:movie_id]
      movie = Movie.find(params[:movie_id])
      @user = User.find_by_fb_id(params[:fb_id])
      @records = movie.find_friends_origin_records(@user.facebook_friends_use_app)
    else
      @user = User.find_by_fb_id(params[:fb_id])
      @records = @user.records
    end
  end

  def show
    @record = Record.includes(:user).find(params[:id])
  end
end
