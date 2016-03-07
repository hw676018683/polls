class Entity < ActiveRecord::Base
  belongs_to :choice
  belongs_to :question
  belongs_to :vote

  before_create :set_user_id
  after_commit :send_notification

  private

  def set_user_id
    self.user_id = vote.user_id
  end

  def send_notification
    select_count = Entity.where(choice_id: choice_id).count
    ActionCable.server.broadcast "polls_#{question.poll_id}", { id: choice_id, select_count: select_count }
  end
end
