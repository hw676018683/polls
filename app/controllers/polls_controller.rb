class PollsController < ApplicationController
  before_action :sign_in_required

  def new
    @poll = current_user.polls.new
  end

  def create
    @poll = current_user.polls.build poll_params
    if @poll.save
      redirect_to @poll
    else
      render text: @poll.errors.full_messages
    end
  end

  def show
    @poll = current_user.polls.find(params[:id])
  end

  def destroy
  end

  private
  def poll_params
    params.require(:poll).permit(:title, :description)
  end
end
