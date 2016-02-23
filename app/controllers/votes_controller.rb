class VotesController < ApplicationController
  before_action :sign_in_required
  before_action :find_poll

  def create
    @vote = @poll.votes.build vote_params
    @vote.user = current_user
    if @vote.save
      render layout: false
    else
      render_json_error(@vote)
    end
  end

  private

  def vote_params
    params.permit(result: [])
  end

  def find_poll
    @poll = Poll.find params[:poll_id]
  end
end
