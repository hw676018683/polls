class Choice < ActiveRecord::Base
  validates :title, presence: {message: '请填写选项标题'}

  belongs_to :question

  def submit(user_id)
    (user_ids << user_id) && self.save

    ActionCable.server.broadcast "polls_#{question.poll_id}", { id: id, select_count: user_ids.count }
  end

  def self.limit_key choice_id
    "#{Rails.env}_choice_#{choice_id}_limit"
  end
end
