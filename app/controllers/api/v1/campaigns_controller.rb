class Api::V1::CampaignsController < Api::ApiController
	def index
		campaigns = Campaign.order("time_active desc").select("id, picture_out")
		render :json => campaigns
	end
	def show
		campaign = Campaign.find(params[:id])
		render :json => campaign
	end
end
