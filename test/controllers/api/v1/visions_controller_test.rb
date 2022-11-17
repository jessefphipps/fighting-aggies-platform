require "test_helper"

class Api::V1::VisionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_video_path = Rails.root.join('storage', 'supplementary_video.mp4').to_s
  end

# Read operation (GET) tests: index endpoint
  test "should get index" do
    get api_v1_vision_index_url
    assert_response :success
  end

  test "index returns all raw data present" do
    get api_v1_vision_index_url
    vision = @response.body
    assert_equal(vision, Vision.all.order(created_at: :desc).to_json, "Raw data coming from index request don't match db's raw data")
  end
  
  # READ operation given ID (GET) tests: show endpoint
  test "show no id" do
    get api_v1_vision_show_url
    assert_response :bad_request
  end
  
  test "show with invalid id: negative" do
    get api_v1_vision_show_url, params: {id: -1}
    assert_response :bad_request
  end
  
  test "show with invalid id: not in database" do
    next_id = Vision.maximum(:id).to_i.next # Queries the next id in DB (non-existent)
    get api_v1_vision_show_url, params: {id: next_id}
    assert_response :bad_request
  end
  
  test "show with valid id" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    last_vision = Vision.create(last_video.id)
    
    get api_v1_vision_show_url, params: {id: last_vision.id}
    assert_response :success
    assert_equal(last_vision.to_json, @response.body, "Requested raw data does not match with query ID")
    
    last_vision.destroy
    last_video.destroy # Remove temporary video
  end
  
  # Create operation (POST) tests
  test "create post no data" do
    post api_v1_vision_create_url
    assert_response :bad_request
  end
  
  test "create with inexistent video id" do
    post api_v1_vision_create_url, params: {id: -1}
    assert_response :bad_request
  end
  
  test "create two raw data for same correct video id" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    
    post api_v1_vision_create_url, params: {id: last_video.id}
    assert_response :created
    
    # Second raw data should fail if there's one already related to video
    post api_v1_vision_create_url, params: {id: last_video.id}
    assert_response :bad_request
    
    last_video.destroy # Remove temporary video
  end
  
  test "create with correct video id after creating video" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    
    post api_v1_vision_create_url, params: {id: last_video.id}
    assert_response :created
    
    last_video.destroy # Remove temporary video
  end
  
  # Destroy operation given ID (DELETE) tests
  test "destroy no id" do
    delete api_v1_vision_destroy_url
    assert_response :bad_request
  end
  
  test "destroy with invalid id: negative" do
    delete api_v1_vision_destroy_url, params: {id: -1}
    assert_response :bad_request
  end
  
  test "destroy with invalid id: not in database" do
    next_id = Vision.maximum(:id).to_i.next # Queries the next id in DB (non-existent)
    delete api_v1_vision_destroy_url, params: {id: next_id}
    assert_response :bad_request
  end
  
  test "destroy with valid id" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    last_vision = Vision.create(last_video.id)
    
    delete api_v1_vision_destroy_url, params: {id: last_vision.id}
    assert_response :success
    
    new_last_vision = Vision.all.order(created_at: :desc).first
    unless assert_not_equal(last_vision.to_json, new_last_vision.to_json, "Raw data was not deleted from DB")
      last_vision.destroy # Manually delete in case video is not deleted by destroy
    end
  end
  
  test "destroying video also destroys raw data" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    last_vision = Vision.create(last_video.id)
    
    delete api_v1_videos_destroy_url, params: {id: last_video.id}
    assert_response :success
    
    new_last_vision = Vision.all.order(created_at: :desc).first
    unless assert_not_equal(last_vision.to_json, new_last_vision.to_json, "Raw data was not deleted from DB when associated video was deleted")
      last_vision.destroy # Manually delete in case video is not deleted by destroy
    end
  end
end
