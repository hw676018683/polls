require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def setup
    @question = build(:question)
  end

  test 'it is valid' do
    assert @question.valid?
  end

  test 'it is invalid with blank title' do
    @question.title = ''
    assert_not @question.valid?
  end
end
