# encoding: utf-8
class MovieTvCrawler
  include Crawler  
  attr_accessor :time, :date

  def post_fetch url, option
    @page_url = url
    url = URI.parse(url)
    resp, data = Net::HTTP.post_form(url, option)
    @page_html = Nokogiri::HTML(resp.body)
  end

  def parse_date
    @date = @page_html.css("h2").text.strip
    puts @date
    /(.*)月(.*)日/ =~ @date
    month = $1.to_i
    day = $2.to_i
    now = DateTime.current
    ymd = "#{now.year}-#{month}-#{day}"
    @date = ymd.to_date
    p @date

  end

  def parse_time
    nodes = @page_html.css(".padl15")
    time = ""
    time_array = []
    nodes.each do |node|
      array = node.parent.text.strip.split("\r\n")
      array.map!{|a| a.strip}
      time_array << array.join(":::")
    end
    @time = time_array.join("|||")
    puts @time
  end

  def save channel
    puts "save start"
    channel_time = ChannelTime.new
    channel_time.channel = channel
    (@time = "00:00:::向未提供") if (@time == "")
    channel_time.time = @time
    channel_time.date = @date
    channel_time.save
    puts "save sucess"
  end

end
