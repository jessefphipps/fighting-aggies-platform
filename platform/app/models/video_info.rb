#!/usr/bin/ruby

require 'streamio-ffmpeg'
require 'json'

class Video
    def initialize(file_path)
        @videopath = file_path
        process_video()
    end

    def to_dict()
        {
            "videopath": @videopath,
            "thumbnailpath": @thumbnailpath,
            "resolution": @resolution,
            "size": @size,
            "duration": @duration,
            "frame_rate": @frame_rate,
        }
    end

    def videopath
        @videopath
    end

    private
    def process_video()
        raise "video file does not exist" unless File.exists?(@videopath)
        video = FFMPEG::Movie.new(@videopath)
        raise "cannot read the video file" unless video.valid?
        
        @resolution = video.resolution #1920x1080
        @size = video.size # in bytes
        @duration = video.duration # in seconds
        @frame_rate = video.frame_rate.to_f.round(2) # float
        
        thumbnail_path = File.join(File.dirname(@videopath), File.basename(@videopath, File.extname(@videopath)) + ".jpg")
        video.screenshot(thumbnail_path, resolution: '320x240')
        raise "error processing thumbnail from video" unless File.exists?(thumbnail_path)
        @thumbnailpath = thumbnail_path
    end
end

# v = Video.new("/mnt/d/datasets/Frame Interpolation Project Results/Paper results/approved_scenes/hands/interpolated_frames_ours.mp4")
# dict_v = v.to_dict
# File.write(File.basename(v.videopath, File.extname(v.videopath)) + ".json", JSON.dump(dict_v))