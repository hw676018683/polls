class Question < ActiveRecord::Base
  validates :title, presence: {message: '请填写问题标题'}

  belongs_to :poll
  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, allow_destroy: true
end
