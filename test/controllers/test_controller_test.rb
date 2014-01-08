require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get heuristic" do
    get :heuristic
    assert_response :success
  end

end
