require 'rails_helper'

RSpec.describe Vote, :type => :model do
  let(:user) { create :user }
  let(:choice_a) { create :choice, limit: 3 }
  let(:choice_b) { create :choice, limit: 0 }
  let(:question) { create :question, choices: [choice_a, choice_b] }
  let(:poll) { create :poll, questions: [question] }
end
