class VideosController < ApplicationController
  def index
    videos = Video.all.order(created_at: :desc)
    render json: videos
  end

  def create
    uploaded_file = params[:data]
    
    file_path = Rails.root.join('storage', 'uploads', uploaded_file.original_filename)
    puts "File path: " + file_path
    
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end
    
    video = Video.create!(file_path)
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
