class Video < ApplicationRecord
    has_one :analysis, dependent: :destroy
    def initialize(file_path)
        file_path = file_path.to_s # Any class that inherits from the base Object class should have to_s
        
        raise "Uploaded file is not a video" and return unless check_video_ext(file_path)
        
        video_path = file_path
        thumbnail_path, resolution, size, duration, frame_rate = process_video(video_path)

        super({ :video_path => video_path, :thumbnail_path => thumbnail_path, :resolution => resolution, :size => size, :duration => duration, :frame_rate => frame_rate })
    end

    private
    def process_video(video_path)
        raise "Video file does not exist" and return unless video_path and File.exist?(video_path)
        ffmpeg_video = FFMPEG::Movie.new(video_path)
        raise "Cannot read the video file" and return unless ffmpeg_video.valid?
        
        resolution = ffmpeg_video.resolution #1920x1080
        size = ffmpeg_video.size # in bytes
        duration = ffmpeg_video.duration # in seconds
        frame_rate = ffmpeg_video.frame_rate.to_f.round(2) # float
        
        thumbnail_path = File.join(File.dirname(video_path), File.basename(video_path, File.extname(video_path)) + ".jpg")
        ffmpeg_video.screenshot(thumbnail_path, resolution: '320x240')
        thumbnail_path = thumbnail_path

        return thumbnail_path, resolution, size, duration, frame_rate 
    end
    
    VID_FORMATS = %w[.avi .flv .mkv .mov .mp4] # add more extensions if anything is left
    def check_video_ext(file_path)
        VID_FORMATS.include? File.extname(file_path)
    end

end
