class Entity < ActiveRecord::Base
  belongs_to :choice
  belongs_to :question
  belongs_to :vote

  validate :validate_limit

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

  def validate_limit
    if choice.limit <= choice.select_count
      errors.add(:base, 'test')
    end
  end
end
