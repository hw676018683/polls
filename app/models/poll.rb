class Poll < ActiveRecord::Base
  validates :title, presence: true

  has_many :questions
end
