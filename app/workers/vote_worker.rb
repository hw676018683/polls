class VoteWorker
  include Sidekiq::Worker

  def perform user_id, poll_id, result
    Vote.create user_id: user_id, poll_id: poll_id, result: result
  end
end