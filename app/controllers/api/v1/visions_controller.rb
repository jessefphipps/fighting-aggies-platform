class Api::V1::VisionsController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
        visions = Vision.all.order(created_at: :desc)
        render json: visions
    end
    
    def create
        unless vision_params[:id]
          render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
        end
    
        begin
          vision = Vision.create!(vision_params[:id])
        rescue => e
          render status: 400, json: {:errormessage => e}.to_json and return
        end
    
        render status: 201, json: vision
    end
    
    def show
        unless vision_params[:id]
          render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
        end
        
        begin
          vision ||= Vision.find(vision_params[:id])
        rescue
          render status: 400, json: {:errormessage => "Raw data for Video with requested ID not found in DB"}.to_json and return
        end
        
        render status: 200, json: vision
    end
    
    def destroy
        unless vision_params[:id]
          render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
        end
        
        begin
          vision ||= Vision.find(vision_params[:id])
        rescue
          render status: 400, json: {:errormessage => "Raw data for Video with requested ID not found in DB"}.to_json and return
        end
        
        vision&.destroy
        render status: 200, json: vision and return
    end
    
    private
    def vision_params
        params.permit(:id)
    end
end
