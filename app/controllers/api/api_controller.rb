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
    promotion = {:picture_link => "https://lh5.ggpht.com/glegjFK0dms70GmBldnJ9MgB3MG4fm9_rd2J8P578-g3kMtMxEayJLn4MWm7wwBqVNw=w124", 
                 :link => "https://play.google.com/store/apps/details?id=com.jumplife.moviediary",
                 :tilte => "電影櫃",
                 :description => nil
    }

    render :json => promotion.to_json
  end

end