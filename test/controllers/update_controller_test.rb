require 'test_helper'

class UpdateControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get update_update_url
    assert_response :success
  end

end
