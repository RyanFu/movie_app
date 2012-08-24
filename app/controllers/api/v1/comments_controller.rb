# encoding: UTF-8
class Api::V1::CommentsController < Api::ApiController
  
  def create
    comment = Comment.new
    comment.user = User.find_by_fb_id(params[:fb_id])
    comment.record_id = params[:record_id]
    comment.text = params[:text]

    if comment.save
      logger.info("params message: #{params.to_json}")
      render :status=>200, :json=>{:message => "success",:comment_id => comment.id}
    else
      logger.info("params message: #{params.to_json}")
      logger.info("error message: #{comment.errors.messages}")
      render :status=>401, :json=>{:message=> "comment create fail" }
    end

  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy

    render :status=>200, :json=>{:message=> "destroy success" }
  end

end
