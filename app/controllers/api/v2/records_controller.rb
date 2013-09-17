class Api::V2::RecordsController < ApplicationController
  def show
  	movie = Movie.find(params[:id])

  	moviediary_rating = "%.2f"%(movie.good_count.to_f / movie.records_count)
  	kresponse = []
  	response =[]
  	k ={}
  	k["IMDB"] = movie.imdb_rating
  	k["moviediary"] = moviediary_rating
    
  	
  	records = Record.includes(:user).movie_record(movie).by_love_count.limit(5)
    records.each do |record|
      n ={}
      n["comment"] = record.comment
      n["score"] = record.score
      n["user_name"] = record.user.name
      n["user_fb_id"] = record.user.fb_id
      response << n
    end

    k["record"] = response

  	render :json => k.to_json
  end	
end
