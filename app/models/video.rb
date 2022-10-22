class Video < ApplicationRecord
    def initialize(file_path)
        video_path = file_path
        thumbnail_path, resolution, size, duration, frame_rate = process_video(video_path)

        super({ :video_path => video_path, :thumbnail_path => thumbnail_path, :resolution => resolution, :size => size, :duration => duration, :frame_rate => frame_rate })
    end

    def to_dict()
        {
            "videopath": self.video_path,
            "thumbnailpath": self.thumbnail_path,
            "resolution": self.resolution,
            "size": self.size,
            "duration": self.duration,
            "frame_rate": self.frame_rate
        }
    end

    private
    def process_video(video_path)
        raise "video file does not exist" unless video_path and File.exist?(video_path)
        ffmpeg_video = FFMPEG::Movie.new(video_path)
        raise "cannot read the video file" unless ffmpeg_video.valid?
        
        resolution = ffmpeg_video.resolution #1920x1080
        size = ffmpeg_video.size # in bytes
        duration = ffmpeg_video.duration # in seconds
        frame_rate = ffmpeg_video.frame_rate.to_f.round(2) # float
        
        thumbnail_path = File.join(File.dirname(video_path), File.basename(video_path, File.extname(video_path)) + ".jpg")
        ffmpeg_video.screenshot(thumbnail_path, resolution: '320x240')
        raise "error processing thumbnail from video" unless File.exist?(thumbnail_path)
        thumbnail_path = thumbnail_path

        return thumbnail_path, resolution, size, duration, frame_rate 
    end

end
