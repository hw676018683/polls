class SessionsController < ApplicationController
  def create
    User.from_omniauth(request.env['omniauth.auth'])
    head :no_content
  end
end
