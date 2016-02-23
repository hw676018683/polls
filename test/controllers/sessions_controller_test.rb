require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:skylark]
  end

  test 'should create user' do
    assert_difference('User.count', 1) do
      get :create, provider: :skylark
    end
  end

  test 'should sign_in the user' do
    get :create, provider: :skylark
    assert_not_nil session[:current_user_id]
    assert_not_nil cookies[:_polls_remember_token]
  end

  test 'should redirect to root_path when signed_in' do
    user = create :user
    sign_in user

    get :create, provider: :skylark
    assert_redirected_to root_path
  end

end
