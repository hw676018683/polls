require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:skylark]
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

  test 'should sign_in the user' do
    get :create, provider: :skylark
    assert_not_nil session[:current_user_id]
    assert_not_nil cookies[:remember_token]
  end

end
