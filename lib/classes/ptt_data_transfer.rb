# encoding: utf-8
class PttDataTransfer
  
  def raw_to_data(movie_name_array)
  	movie_name_array.each do |movie_name|
  	  @movie = Movie.where("name like ?", "%#{movie_name}%")

      @movie_id = @movie[0][:id]
      @movie_name = @movie[0][:name]
      puts @movie_id
      puts @movie_name
    

      #PttRaw.where("title like ? and title like ?", "%惡靈古堡5%", "%負雷%")
      goodDatas = PttRaw.where("title like ? and title like ?", "%#{movie_name}%", "%好雷%")
      save_to_data(goodDatas, 0)

      normalDatas = PttRaw.where("title like ? and title like ?", "%#{movie_name}%", "%普雷%")
      save_to_data(normalDatas, 1)

      badDatas = PttRaw.where("title like ? and title like ?", "%#{movie_name}%", "%負雷%")
      save_to_data(badDatas, 2)
  	end
  end

  def save_to_data(datas, score)
    datas.each do |data|
        ptt_user_id = data.ptt_user_id
        title = data.title
        link = "www.ptt.cc" + data.link
        
        movie_id = @movie_id

        #puts "ptt_user_id: " + ptt_user_id
        #puts "title: " + title
        #puts "link: " + link
        #puts "score: " + score.to_s
        #puts "movie id: " + movie_id.to_s

        pttData = PttData.new(:ptt_user_id => ptt_user_id, :title => title, :link => link, :score => score,
        	        :movie_id => movie_id)
        pttData.save
    end
  end  

end