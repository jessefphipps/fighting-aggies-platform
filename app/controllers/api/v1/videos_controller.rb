class Api::V1::VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    videos = Video.all.order(created_at: :desc)
    render json: videos
  end

  def create
    uploaded_file = params[:data]
    
    file_path = Rails.root.join('storage', 'uploads', uploaded_file.original_filename)
    
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end
    
    video = Video.create!(file_path.to_s)
    if video
      render json: video
    else
      render json: video.errors
    end
  end

  def show
    if video
      render json: video
    else
      render json: video.errors
    end
  end

  def destroy
    video&.destroy
    render json: { message: 'Video deleted' }
  end
  
  private
  def video_params
    params.permit(:data)
  end
  
  def video
    @video ||= Video.find(params[:id])
  end
end

