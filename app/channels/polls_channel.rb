class PollsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "polls_#{params[:poll_id]}"
  end
end
