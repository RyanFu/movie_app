class Api::ApiController  < ActionController::Base
  respond_to :json
  before_filter :check_format_json
  
  def check_format_json
    if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json"}
        return
    end
  end

  def promotion
    promotion = {:picture_link => nil, 
                 :link => nil,
                 :tilte => nil,
                 :description => nil
    }

    render :json => promotion.to_json
  end

end