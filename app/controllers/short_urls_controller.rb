class ShortUrlsController < ApplicationController
  def show
    poll = Poll.find_by short_url_key: params[:key]

    redirect_to fill_poll_url(poll)
  end
end
