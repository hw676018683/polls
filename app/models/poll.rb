class Poll < ActiveRecord::Base
  validates :title, presence: true
end
