class Choice < ActiveRecord::Base
  validates :title, presence: {message: '请填写选项标题'}

  belongs_to :question

  def submit(user)
    if limit and user_ids.length < limit and !question.poll.user_submitted?(user)
      (user_ids << user.id) && self.save
    end
  end
end
