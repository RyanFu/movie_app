collection @news
attributes :id, :title, :content, :link, :picture_url, :news_type

node(:created_at){ |news| news.created_at.strftime "%Y/%m/%d %H:%M" }