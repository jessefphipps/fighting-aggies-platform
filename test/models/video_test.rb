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
  
  test "Invalid video file path" do
    path = Rails.root.join('storage', 'supplementary_video2.mp4').to_s
    FileUtils.touch(path) # Creates an empty mp4 on the server
    
    error = assert_raise(StandardError){
      Video.new(path)
    }
    assert_equal "Cannot read the video file", error.message
    
    FileUtils.rm(path) # Cleaning empty file
  end
end
