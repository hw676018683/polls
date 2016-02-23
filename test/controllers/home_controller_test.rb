require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  include ApplicationHelper

  def setup
    @user = create :user
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
  end

  test "should redirect to auth_path" do
    get :index
    assert_redirected_to auth_path(:skylark)
  end

end
