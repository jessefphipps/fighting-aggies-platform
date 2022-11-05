class Api::V1::AnalysesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    analyses = Analysis.all.order(created_at: :desc)
    render json: analyses
  end

  def create
    unless analysis_params[:id]
      render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
    end
    
    begin
      analysis = Analysis.create!(analysis_params[:id])
    rescue => e
      render status: 400, json: {:errormessage => e}.to_json and return
    end
    
    render status: 201, json: analysis
  end

  def show
    unless analysis_params[:id]
      render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
    end
    
    begin
      analysis ||= Analysis.find(analysis_params[:id])
    rescue
      render status: 400, json: {:errormessage => "Analysis for Video with requested ID not found in DB"}.to_json and return
    end
    
    render status: 200, json: analysis
  end

  def destroy
    unless analysis_params[:id]
      render status: 400, json: {:errormessage => "No ID was provided"}.to_json and return
    end
    
    begin
      analysis ||= Analysis.find(analysis_params[:id])
    rescue
      render status: 400, json: {:errormessage => "Analysis for Video with requested ID not found in DB"}.to_json and return
    end
    
    analysis&.destroy
    render status: 200, json: analysis and return
  end

  private
  def analysis_params
    params.permit(:id)
  end
end
