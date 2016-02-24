require 'rails_helper'

RSpec.describe Poll, :type => :model do
  let(:user) { create :user }
  let(:choice_a) { create :choice, limit: 3 }
  let(:choice_b) { create :choice, limit: 0 }
  let(:question) { create :question, choices: [choice_a, choice_b] }
  let!(:poll) { create :poll, questions: [question] }

  describe '#create' do
    it 'cache limit of choices' do
      expect(Poll.redis.lrange(Choice.limit_key(choice_a.id), 0, -1)).to match_array ['1','1','1']
    end
  end

  describe '#cache_voter' do
    it 'add user_id to redis list' do
      poll.cache_voter user
      expect(Poll.redis.lrange(Poll.voters_key(poll.id), 0, -1).include?(user.id.to_s)).to be_truthy
    end
  end

  describe '#submitted?' do
    it 'returns ture if user has voted' do
      poll.cache_voter user
      expect(poll.submitted?(user)).to be_truthy
    end
  end

  describe '#check_if_beyong_limit' do
    it 'pops one limit if not beyong limit' do
      expect {
        poll.check_if_beyong_limit [choice_a.id]
      }.to change { Poll.redis.lrange(Choice.limit_key(choice_a.id), 0, -1).size }.by -1
    end

    it 'returns true if not beyong limit' do
      expect(poll.check_if_beyong_limit [choice_a.id]).to be_falsey
    end

    it 'donot pop any limit if beyong limit' do
      expect {
        poll.check_if_beyong_limit [choice_a.id, choice_b.id]
      }.not_to change { Poll.redis.lrange(Choice.limit_key(choice_a.id), 0, -1).size }
    end

    it 'returns false if beyong limit' do
      expect(poll.check_if_beyong_limit [choice_a.id, choice_b.id]).to be_truthy
    end
  end
end
