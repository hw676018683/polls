class Choice < ActiveRecord::Base
  validates :title, presence: {message: '请填写选项标题'}

  belongs_to :question
  has_many :entities

  def select_count
    entities.count
  end

  def self.limit_key choice_id
    "#{Rails.env}_choice_#{choice_id}_limit"
  end
end
