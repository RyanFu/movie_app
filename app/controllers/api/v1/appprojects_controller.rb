class Api::V1::AppprojectsController < ApplicationController
  def index
    appprojects = Appproject.select("name,iconurl,pack,clas,promo_title,content")
    n ={}
    response = []
    n["probability"] = 4
    n["promotions"] = appprojects
    
  	render :json => n.to_json

		
  end	
end
