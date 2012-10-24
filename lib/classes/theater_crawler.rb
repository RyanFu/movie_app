# encoding: utf-8
class TheaterCrawler
  include Crawler
  
  attr_accessor :names, :location

  def post_fetch url, option
    @page_url = url
    url = URI.parse(url)
    resp, data = Net::HTTP.post_form(url, option)
    @page_html = Nokogiri::HTML(resp.body)
  end

  def parse_theater

    nodes = @page_html.css(".group")

    nodes.each do |node|
      area_node = node.css(".hd")
      area = Area.new
      area.name = area_node.text.strip
      area.save
      
      theaters_node = node.css("tbody tr")
      theaters_node.each do |theater_node|
        tds = theater_node.css("td")
        theater = Theater.new
        theater.name = tds[0].text.strip
        theater.location = tds[1].children[0].text.strip
        theater.phone = tds[1].children[1].text.strip
        theater.area = area
        theater.save
      end

    end

  end

end
