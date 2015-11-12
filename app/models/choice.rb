class Choice < ActiveRecord::Base
  validates :title, presence: {message: '请填写选项标题'}

  belongs_to :question
end
