require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
  end

  test 'it is valid' do
    assert @user.save
  end

  test 'it is invalid with blank attributes' do
    @user.save

    %w(uid name).each do |attr|
      @user.send "#{attr}=", ''
      assert_not @user.valid?
      @user.reload
    end
  end

  test 'should create inexistent user' do
    auth_hash = OmniAuth.config.mock_auth[:skylark]

    assert_difference('User.count', 1) do
      User.from_omniauth(auth_hash)
    end
  end

  test 'should update existent user' do
    auth_hash = OmniAuth.config.mock_auth[:skylark]
    create(:user, uid: auth_hash['uid'])

    assert_no_difference('User.count') do
      User.from_omniauth(auth_hash)
    end
  end
end
