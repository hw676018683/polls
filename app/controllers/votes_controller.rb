class VotesController < ApplicationController
  before_action :sign_in_required
  before_action :find_poll

  def create
    if @poll.submitted?(current_user)
      render json: { state: :failure, errors: ['你已经投票'] }, status: 422
    else
      if @poll.check_if_beyong_limit(vote_params[:result])
        render json: { state: :failure, errors: ['超过限制'] }, status: 422
      else
        @poll.cache_voter current_user
        VoteWorker.perform_async current_user.id, @poll.id, params[:result]
        render json: { state: :success }
      end
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
