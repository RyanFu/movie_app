# encoding: UTF-8
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
                 :description => nil,
                 :version => 1
    }

    render :json => promotion.to_json
  end

  def movieinfo_promotion
    promotion = {:picture_link => "https://lh5.ggpht.com/siMxWIvJbX_K-y3DCqpmKh87JzqvZVK2-QDSOQGA2tzJmkiXsEQnogDH9AfS8cWB6SY=w124", 
                 :link => "http://goo.gl/zsybo",
                 :tilte => "測試",
                 :description => "test test test",
                 :version => 1
    }

    render :json => promotion.to_json
  end

end