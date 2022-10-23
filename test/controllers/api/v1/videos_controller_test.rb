require "test_helper"

class Api::V1::VideosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_videos_index_url
    assert_response :success
  end
end
