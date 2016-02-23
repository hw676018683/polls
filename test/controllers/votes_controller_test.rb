require 'test_helper'

class VotesControllerTest < ActionController::TestCase

  def setup
    @user = create(:user)
    @poll = create(:poll)
    sign_in @user
  end

  test 'create should create a new votes' do
    assert_difference('Vote.count', 1) do
      post :create, { result: [{  }] }
    end
  end
end
