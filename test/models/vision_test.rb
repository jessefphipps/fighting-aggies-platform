require "test_helper"

class VisionTest < ActiveSupport::TestCase
  setup do
    @valid_video_path = Rails.root.join('storage', 'supplementary_video.mp4').to_s
  end
  
  test "Invalid video id" do
    invalid_id = -1
    error = assert_raise(StandardError){
      Vision.new(invalid_id)
    }
    
    assert_equal "Video with id " + invalid_id.to_s + " does not exist", error.message
  end
  
  test "Duplicated video id" do
    # Create dummy video
    Video.create(@valid_video_path)
    last_video = Video.order("created_at").last
    last_video_id = last_video.id
    
    # Creates valid vision for dummy video
    valid_vision = Vision.create(last_video_id)
    
    # Should throw error for already existent vision report
    error = assert_raise(StandardError){
      Vision.new(last_video_id)
    }
    assert_equal "Raw data for video with id " + last_video_id.to_s + " already exists", error.message
    
    # destroy dummy video from db. Cascade delete from video also deletes vision
    last_video.destroy
    
    new_last_video = Video.order("created_at").last
    assert_not_equal(new_last_video.id, last_video_id, "Video was not deleted from db")
    new_last_vision = Vision.order("created_at").last
    assert_not_equal(new_last_vision.id, valid_vision.id, "Vision was not deleted from db")
  end
  
  test "Valid video id" do
    # Create dummy video
    Video.create(@valid_video_path)
    last_video = Video.order("created_at").last
    last_video_id = last_video.id
    
    # Creates valid vision for dummy video
    created_vision = Vision.create(last_video_id)
    last_vision = Vision.order("created_at").last
    
    # Created vision should match the one in db
    assert_equal created_vision.id, last_vision.id
    
    # destroy dummy video from db. Cascade delete from video also deletes vision
    last_video.destroy
    
    new_last_video = Video.order("created_at").last
    assert_not_equal(new_last_video.id, last_video_id, "Video was not deleted from db")
    new_last_vision = Vision.order("created_at").last
    assert_not_equal(new_last_vision.id, last_vision.id, "Vision was not deleted from db")
  end
end
