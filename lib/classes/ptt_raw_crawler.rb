# encoding: utf-8
class PttRawCrawler
  include Crawler
  
  #PttRaw.where("title like ? and title like ?", "%巴黎魅影%", "%雷%")

  def start_task
    (1..928).each do |i|
      #puts "#{word}, #{@name}" # 字串相加
      url = "http://www.ptt.cc/bbs/movie/index#{i}.html"
      parse_data(url)
    end  	
  end

  def parse_data(url)
    fetch url

    @trs = @page_html.css("#prodlist tr")

    @trs.each do |tr|
      tds = tr.css("td")
      userId = tds[4].text
      title = tds[5].text
      link =  tds[5].css("a")[0][:href]

      #puts "User Id: " + userId
      #puts "title: " + title
      #puts "link: " + link

      save_data(userId, title, link)
      
    end
    
  end

  def save_data(userId, title, link)
    pttRaw = PttRaw.new
    pttRaw.ptt_user_id = userId
    pttRaw.title = title
    pttRaw.link = link
    pttRaw.save
  end

  def get_user_id (url)
    fetch url
    @userIds = @page_html.css("#prodlist td[@width = \"120\"]")
    
    userIds.each do |userId|
      puts userId 
    end

  end

  def get_title
  end

  def get_link
  end

end
