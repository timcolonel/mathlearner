require 'test_helper'

class AlgorithmControllerTest < ActionController::TestCase
  test "should get use" do
    get :use
    assert_response :success
  end

end
