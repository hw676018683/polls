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
end
