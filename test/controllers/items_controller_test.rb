require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "should get new" do
    get :home
    assert_response :success
    
  end

end
