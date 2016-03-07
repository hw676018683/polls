class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  has_many :entities

  validates :user_id, uniqueness: { scope: [:poll_id] }

  accepts_nested_attributes_for :entities
end
