class Api::V1::UsersController < Api::ApiController
  
  def create
    
    logger.info("create user params: #{params}")

    user = User.find_by_fb_id(params[:fb_id])


    u = User.new
    u.fb_id = params[:fb_id]
    u.fb_token = params[:fb_token]
    u.name = params[:name]
    u.sex = params[:sex]
    u.birthday = params[:birthday]
    u.password = "111111"
    u.email = u.fb_id + "@gmail.com"
     
    if user
      render :status=>200, :json=>{:message => "already registered"}
    elsif u.save
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{u.errors.messages}")
      render :status=>401, :json=>{:message=> "register fail" }
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{@user.errors.messages}")
      render :status=>401, :json=>{:message=> "update fail" }
    end

  end
end
