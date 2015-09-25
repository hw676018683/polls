class Question < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :poll
  has_many :choices

  accepts_nested_attributes_for :choices, allow_destroy: true
end
