require "test_helper"

class AnalysisTest < ActiveSupport::TestCase
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
  
  test "Missing vision for provided video id" do
    # Create dummy video
    Video.create(@valid_video_path)
    last_video = Video.order("created_at").last
    last_video_id = last_video.id
    
    # Tries to create analysis without having a vision. Should not throw error.
    Analysis.create(last_video_id)
  
    
    # destroy dummy video from db.
    last_video.destroy
    
    new_last_video = Video.order("created_at").last
    assert_not_equal(new_last_video.id, last_video_id, "Video was not deleted from db")
  end
  
  test "Duplicated video id" do
    # Create dummy video
    Video.create(@valid_video_path)
    last_video = Video.order("created_at").last
    last_video_id = last_video.id
    
    # Creates valid vision for dummy video
    created_vision = Vision.create(last_video_id)
    
    # Creates valid analysis for dummy video
    created_analysis = Analysis.create(last_video_id)
    
    # Should throw error for already existent analysis report
    error = assert_raise(StandardError){
      Analysis.new(last_video_id)
    }
    assert_equal "Analysis for video with id " + last_video_id.to_s + " already exists", error.message
    
    # destroy dummy video from db. Cascade delete from video also deletes vision and analysis
    last_video.destroy
    
    new_last_video = Video.order("created_at").last
    assert_not_equal(new_last_video.id, last_video_id, "Video was not deleted from db")
    new_last_vision = Vision.order("created_at").last
    assert_not_equal(new_last_vision.id, created_vision.id, "Vision was not deleted from db")
    new_last_analysis = Analysis.order("created_at").last
    assert_not_equal(new_last_analysis.id, created_analysis.id, "Analysis was not deleted from db")
  end
  
  test "Valid video id" do
    # Create dummy video
    Video.create(@valid_video_path)
    last_video = Video.order("created_at").last
    last_video_id = last_video.id
    
    # Creates valid vision for dummy video
    created_vision = Vision.create(last_video_id)
    
    # Creates analysis after both video and vision are created
    created_analysis = Analysis.create(last_video_id)
    last_analysis = Analysis.order("created_at").last
    
    # Created analysis should match the one in db
    assert_equal created_analysis.id, last_analysis.id
    
    # destroy dummy video from db. Cascade delete from video also deletes vision and analysis
    last_video.destroy
    
    new_last_video = Video.order("created_at").last
    assert_not_equal(new_last_video.id, last_video_id, "Video was not deleted from db")
    new_last_vision = Vision.order("created_at").last
    assert_not_equal(new_last_vision.id, created_vision.id, "Vision was not deleted from db")
    new_last_analysis = Analysis.order("created_at").last
    assert_not_equal(new_last_analysis.id, created_analysis.id, "Analysis was not deleted from db")
  end
end
