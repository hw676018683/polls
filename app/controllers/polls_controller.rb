class PollsController < ApplicationController
  before_action :sign_in_required
  before_action :find_poll, only: [:show, :destroy, :update, :fill]

  def new
    @poll = current_user.polls.new
  end

  def create
    @poll = current_user.polls.build poll_params
    if @poll.save
      render :show
    else
      render_json_error @poll
    end
  end

  def show
  end

  def update
    if @poll.update poll_params
      render :show
    else
      render_json_error @poll
    end
  end

  def destroy
    @poll.destroy
    head :no_content
  end

  def fill
  end

  private
  def poll_params
    params.require(:poll).permit(:title, :description,
                                 questions_attributes:
                                 [
                                   :id, :title, :multiple, :_destroy,
                                   choices_attributes:
                                   [
                                     :id, :title, :limit, :_destroy
                                   ]
                                 ]
                                )
  end

  def find_poll
    @poll = current_user.polls.find(params[:id])
  end
end
