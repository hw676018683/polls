class VoteWorker
  include Sidekiq::Worker

  def perform user_id, poll_id, entities_attributes
    Vote.create user_id: user_id, poll_id: poll_id, entities_attributes: entities_attributes
  end
end