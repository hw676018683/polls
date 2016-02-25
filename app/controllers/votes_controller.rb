class VotesController < ApplicationController
  before_action :sign_in_required
  before_action :find_poll, except: [:index]
  before_action :find_vote, only: [:show]

  def create
    if @poll.writable?
      if @poll.submitted?(current_user)
        render json: { state: :failure, errors: ['你已经投票'] }, status: 422
      else
        if @poll.check_if_beyong_limit(vote_params[:result])
          render json: { state: :failure, errors: ['超过限制'] }, status: 422
        else
          @poll.cache_voter current_user
          VoteWorker.perform_async current_user.id, @poll.id, params[:result]
          render json: { state: :success }, location: poll_path(@poll)
        end
      end
    else
      render json: { errors: ['现在还未到投票时间'] }, status: 422
    end
  end

  def show
  end

  def index
    @votes = current_user.votes.includes(:poll)
  end

  private

  def vote_params
    params.permit(result: [])
  end

  def find_poll
    @poll = Poll.find params[:poll_id]
  end

  def find_vote
    @vote = @poll.votes.find params[:id]
  end
end
