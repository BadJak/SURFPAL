require 'test_helper'

class EditControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get edit_edit_url
    assert_response :success
  end

end
