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
    promotion = {:picture_link => "ttp://pic.pimg.tw/jumplives/1367922942-4188405356.jpg?v=1367922978", 
                 :link => "https://play.google.com/store/apps/details?id=com.jumplife.movienews&referrer=utm_source%3Dmovie_diary_inapp%26utm_campaign%3Dmovie_diary_inapp",
                 :tilte => "電影窩",
                 :description => "電影經典名句, 深度影評, 明星趣聞 - 趕快加入窩在電影窩App的行列吧!",
                 :version => 2
    }

    render :json => promotion.to_json
  end

  #def movieinfo_promotion
  #  promotion = {:picture_link => "http://ext.pimg.tw/jumplives/1352973893-4060856514.png?v=1352973903", 
  #               :link => "market://details?id=com.jumplife.movieinfo",
  #               :tilte => "幫電影時刻表評分",
  #               :description => "歡迎到 Google Play 給電影時刻表中肯的建議與評價, 謝謝！",
  #               :version => 1
  #  }
  #  render :json => promotion.to_json
  #end

  def movieinfo_promotion

    promotion = {:picture_link => "http://ext.pimg.tw/jumplives/1352973893-4060856514.png?v=1352973903", 
                 :link => "http://goo.gl/yJIyn",
                 :tilte => "幫電影時刻表評分",
                 :description => "歡迎到 Google Play 給電影時刻表中肯的建議與評價, 謝謝！",
                 :version => 4
    }
    render :json => promotion.to_json
  end
end