require 'rails_helper'

RSpec.describe Vote, :type => :model do
  describe 'associations' do
    it { belong_to(:user) }
  end
end
