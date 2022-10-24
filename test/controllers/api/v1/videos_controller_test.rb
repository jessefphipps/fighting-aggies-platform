require "test_helper"

class Api::V1::VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jpg_file = fixture_file_upload(Rails.root.join('storage', 'supplementary_video.jpg').to_s)
    @valid_video_path = Rails.root.join('storage', 'supplementary_video.mp4').to_s
    @mp4_file = fixture_file_upload(@valid_video_path)
    
    @dummy_video_path = Rails.root.join('storage', 'supplementary_video2.mp4').to_s
    FileUtils.touch(@dummy_video_path)
    @dummy_mp4_file = fixture_file_upload(Rails.root.join('storage', 'supplementary_video2.mp4').to_s)
  end
  
  # Read operation (GET) tests: index endpoint
  test "should get index" do
    get api_v1_videos_index_url
    assert_response :success
  end
  
  test "index returns all videos" do
    get api_v1_videos_index_url
    videos = @response.body
    assert_equal(videos, Video.all.order(created_at: :desc).to_json, "Videos coming from index request don't match db's videos")
  end
  
  # READ operation given ID (GET) tests: show endpoint
  test "show no id" do
    get api_v1_videos_show_url
    assert_response :bad_request
  end
  
  test "show with invalid id: negative" do
    get api_v1_videos_show_url, params: {id: -1}
    assert_response :bad_request
  end
  
  test "show with invalid id: not in database" do
    next_id = Video.maximum(:id).to_i.next # Queries the next id in DB (non-existent)
    get api_v1_videos_show_url, params: {id: next_id}
    assert_response :bad_request
  end
  
  test "show with valid id" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    
    get api_v1_videos_show_url, params: {id: last_video.id}
    assert_response :success
    assert_equal(last_video.to_json, @response.body, "Requested video does not match with query ID")
    
    last_video.destroy # Remove temporary video
  end
  
  
  # Create operation (POST) tests
  test "create post no data" do
    post api_v1_videos_create_url
    assert_response :bad_request
  end
  
  test "create with incorrect file format" do
    post api_v1_videos_create_url, params: {data: @jpg_file}
    assert_response :bad_request
  end
  
  test "create with corrupted video file" do
    post api_v1_videos_create_url, params: {data: @dummy_mp4_file}
    assert_response :bad_request
  end
  
  test "create with correct video file" do
    post api_v1_videos_create_url, params: {data: @mp4_file}
    assert_response :created
  end
  
  # Destroy operation given ID (DELETE) tests
  test "destroy no id" do
    delete api_v1_videos_destroy_url
    assert_response :bad_request
  end
  
  test "destroy with invalid id: negative" do
    delete api_v1_videos_destroy_url, params: {id: -1}
    assert_response :bad_request
  end
  
  test "destroy with invalid id: not in database" do
    next_id = Video.maximum(:id).to_i.next # Queries the next id in DB (non-existent)
    delete api_v1_videos_destroy_url, params: {id: next_id}
    assert_response :bad_request
  end
  
  test "destroy with valid id" do
    last_video = Video.create(@valid_video_path) # Add temporary video
    
    delete api_v1_videos_destroy_url, params: {id: last_video.id}
    assert_response :success
    
    new_last_video = Video.all.order(created_at: :desc).first
    unless assert_not_equal(last_video.to_json, new_last_video.to_json, "Video was not deleted from DB")
      last_video.destroy # Manually delete in case video is not deleted by destroy
    end
  end

  teardown do
    FileUtils.rm(@dummy_video_path)
  end
end
  
  

  
#   test "Correct video file path for existing and valid sample video" do
#     path = Rails.root.join('storage', 'supplementary_video.mp4').to_s
    
#     Video.create(path)
#     assert(File.exist?(path), "Video file does not exist")
    
#     last_video = Video.order("created_at").last
#     # puts last_video.to_s
    
#     assert_equal(last_video.video_path, path, "Recorded video path is not the same as in db")
    
#     thumbnail_p = path
#     thumbnail_p[".mp4"] = ".jpg"
#     assert_equal(last_video.thumbnail_path, thumbnail_p, "Recorded thumbnail path is not the same as in db")
#     assert(File.exist?(last_video.thumbnail_path), "Generated thumbnail file does not exist")
    
#     assert_equal(last_video.resolution, "1280x720", "Recorded resolution does not match sample video")
#     assert_equal(last_video.size, 7763245, "Recorded size does not match sample video")
#     assert_equal(last_video.duration, 133, "Recorded duration does not match sample video")
#     assert_equal(last_video.frame_rate, 10.0, "Recorded frame rate does not match sample video")
    
#     id = last_video.id
#     last_video.destroy
#     new_last_video = Video.order("created_at").last
#     assert_not_equal(new_last_video.id, id, "Video was not deleted from db")
#   end
