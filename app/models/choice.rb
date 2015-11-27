class Choice < ActiveRecord::Base
  validates :title, presence: {message: '请填写选项标题'}

  belongs_to :question

  def submit(user)
    if user_ids.length < limit && !user_ids.include?(user.id) && !question.poll.user_submitted?(user)
      (user_ids << user.id) && self.save
    end
  end
end
