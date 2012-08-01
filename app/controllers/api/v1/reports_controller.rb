class Api::V1::ReportsController < Api::ApiController
  def create
    report = Report.new(params[:report])

    if report.save
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{report.errors.messages}")
      render :status=>401, :json=>{:message=> "register fail" }
    end
  end

  def update
    @report = report.find(params[:id])

    if @report.update_attributes(params[:user])
      render :status=>200, :json=>{:message => "success"}
    else
      logger.info("error message: #{@report.errors.messages}")
      render :status=>401, :json=>{:message=> "update fail" }
    end

  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    render :status=>401, :json=>{:message=> "destroy success" }
  end

end
