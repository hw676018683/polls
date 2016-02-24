require 'rails_helper'

RSpec.describe Vote, :type => :model do
  let(:user) { create :user }
  let(:poll) { create :poll }
  let(:vote) { create :vote, user: user, poll: poll }
end
