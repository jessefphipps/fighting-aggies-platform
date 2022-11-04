class Api::V1::ModelApiController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        model_api = ModelApi.all.order(created_at: :desc)
        render json: model_api
    end

    def create
        model_api = ModelApi.create(home_team: "Texas A&M",
            away_team: "Alabama",
            home_score: 24,
            away_score: 21,
            quarter: 3,
            time: "2:50",
            possession: "Texas A&M",
            play_down: 2,
            yard_to_10: 4,
            play_name: "PA Y-Drag Wheel",
            qb_name: "Conner Weigman",
            wr1_name: "Evan Stewart",
            wr1_route: "Slant",
            wr1_good_route: 1,
            wr2_name: "Muhsin Muhammad III",
            wr2_route: "Slant",
            wr2_good_route: 1,
            te_name: "Max Wright",
            te_route: "Drag",
            te_good_route: 0,
            rb_name: "Devon Achane",
            rb_route: "Slant",
            rb_good_route:  0,
            received_by: "Muhsin Muhammad III", 
            yards_gained: 18)
    end

    def show
    end

    def destroy
        unless model_api_params[:id]
          render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
        end
        
        begin
          model_api ||= ModelApi.find(model_api_params[:id])
        rescue
          render status: 400, json: {:errormessage => "Model data with requested ID not found in DB"}.to_json and return
        end
        
        model_api&.destroy
        render status: 200, json: model_api and return
      end

    private
    def model_api_params
        params.permit(:data, :id)
    end
end
