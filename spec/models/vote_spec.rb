require 'rails_helper'

RSpec.describe Vote, :type => :model do
  let(:user) { create :user }
  let(:choice_a) { create :choice, limit: 3 }
  let(:choice_b) { create :choice, limit: 0 }
  let(:question) { create :question, choices: [choice_a, choice_b] }
  let(:poll) { create :poll, questions: [question] }
  let!(:vote) { create :vote, user: user, poll: poll, result: [choice_a.id] }

  describe '#create' do
    it 'updates user_ids of choices' do
      expect(choice_a.reload.user_ids.include? user.id).to be_truthy
    end
  end
end
