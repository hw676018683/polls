require 'test_helper'

class PollTest < ActiveSupport::TestCase
  def setup
    @poll = build(:poll)
  end

  test 'it is valid' do
    assert @poll.valid?
  end

  test 'it is invalid with blank title' do
    @poll.title = ''
    assert_not @poll.valid?
  end
end
