class Question < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :poll
  has_many :choices
end
