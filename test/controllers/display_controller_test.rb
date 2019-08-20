require 'test_helper'

class DisplayControllerTest < ActionDispatch::IntegrationTest
  test "should get display" do
    get display_display_url
    assert_response :success
  end

end
