require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:skylark]
  end

  test 'should get create' do
    get :create, provider: :skylark
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count', 1) do
      get :create, provider: :skylark
    end
  end

end
