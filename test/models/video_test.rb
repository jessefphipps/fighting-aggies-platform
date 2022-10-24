require "test_helper"
require 'fileutils'

class VideoTest < ActiveSupport::TestCase
  
  test "Empty video file path" do
    error = assert_raise(StandardError){
      Video.new("")
    }
    
    assert_equal "Uploaded file is not a video", error.message
  end
  
  test "Incorrect file format (jpg)" do
    path = Rails.root.join('storage', 'supplementary_video.jpg').to_s
    error = assert_raise(StandardError){
      Video.new(path)
    }
    
    assert_equal "Uploaded file is not a video", error.message
  end
  
  test "Non-existent video file path" do
    path = Rails.root.join('storage', 'supplementary_video2.mp4').to_s
    error = assert_raise(StandardError){
      Video.new(path)
    }
    
    assert_equal "Video file does not exist", error.message
  end
  
  test "Corrupted video file path" do
    path = Rails.root.join('storage', 'supplementary_video2.mp4').to_s
    FileUtils.touch(path) # Creates an empty mp4 on the server
    
    error = assert_raise(StandardError){
      Video.new(path)
    }
    assert_equal "Cannot read the video file", error.message
    
    FileUtils.rm(path) # Cleaning empty file
  end
  
  test "Correct video file path for existing and valid sample video" do
    path = Rails.root.join('storage', 'supplementary_video.mp4').to_s
    
    Video.create(path)
    assert(File.exist?(path), "Video file does not exist")
    
    last_video = Video.order("created_at").last
    # puts last_video.to_s
    
    assert_equal(last_video.video_path, path, "Recorded video path is not the same as in db")
    
    thumbnail_p = path
    thumbnail_p[".mp4"] = ".jpg"
    assert_equal(last_video.thumbnail_path, thumbnail_p, "Recorded thumbnail path is not the same as in db")
    assert(File.exist?(last_video.thumbnail_path), "Generated thumbnail file does not exist")
    
    assert_equal(last_video.resolution, "1280x720", "Recorded resolution does not match sample video")
    assert_equal(last_video.size, 7763245, "Recorded size does not match sample video")
    assert_equal(last_video.duration, 133, "Recorded duration does not match sample video")
    assert_equal(last_video.frame_rate, 10.0, "Recorded frame rate does not match sample video")
    
    id = last_video.id
    last_video.destroy
    new_last_video = Video.order("created_at").last
    assert_not_equal(new_last_video.id, id, "Video was not deleted from db")
  end
end
