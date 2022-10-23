class Api::V1::VideosController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    videos = Video.all.order(created_at: :desc)
    render json: videos
  end

  def create
    uploaded_file = params[:data]
    
    file_path = Rails.root.join('storage', 'uploads', uploaded_file.original_filename)
    
    file_dir = File.dirname(file_path)
    FileUtils.mkdir_p(file_dir) unless File.directory?(file_dir)
    
    begin
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end
    rescue
      render status: 500, json: {:errormessage => "Not able to save video file due to server capacity."}.to_json and return
    end
    
    begin
      video = Video.create!(file_path.to_s)
    rescue => e
      render status: 400, json: {:errormessage => e}.to_json and return
    end
    
    render json: video
  end
  
  # TODO
  def show
    if video
      render json: video
    else
      render json: video.errors
    end
  end
  
  # TODO
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

