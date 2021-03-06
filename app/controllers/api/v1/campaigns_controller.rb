class Api::V1::CampaignsController < Api::ApiController
	def index
		campaigns = Campaign.where("time_active > ? AND is_show = ?",Time.now.to_datetime,1).order("time_active desc").select("id, picture_out")
		# if campaigns.size > 1
		  # puts "not empty"
		  render :json => campaigns
		# else
		  # puts "empty"
		  # render :status=>200, :json=>{:message => "empty"}
		# end	
		
		
	end
	def show
		campaign = Campaign.select("picture_out,picture_in,title,description,time_active,measure,teach_pic,award_condition,award,award_pic,precaution,movie_id").find(params[:id])
		# campaign :except => [:created_at,:updated_at,:is_show]
		render :json => campaign
	end
	def announce_list
		announces = Campaign.where("time_active < ? AND is_show = ?",Time.now.to_datetime,1).order("time_active desc").select("id, picture_out")
        # if announces .size > 1
          render :json => announces
        # else
		  # render :status=>200, :json=>{:message => "empty"}
		# end

    end
    def announce
        announce = Campaign.select("title,picture_in, award_list").find(params[:id])
        render :json => announce 

    end

end
