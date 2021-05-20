require "test_helper"

class EnrollsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enrolls_index_url
    assert_response :success
  end
end
