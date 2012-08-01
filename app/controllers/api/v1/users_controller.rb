class Api::V1::UsersController < Api::ApiController
  
  def create
    u = User.new(params[:user])
    u.password = "111111"
    u.email = u.fb_id + "@gmail.com"

    if u.save
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
