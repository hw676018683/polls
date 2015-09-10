require 'test_helper'

class ChoiceTest < ActiveSupport::TestCase
  def setup
    @choice = build(:choice)
  end

  test 'it is valid' do
    assert @choice.valid?
  end

  test 'it is invalid with blank title' do
    @choice.title = ''
    assert_not @choice.valid?
  end
end
