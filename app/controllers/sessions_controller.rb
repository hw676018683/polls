class SessionsController < ApplicationController
  before_action :no_signed_in_required

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in user

    redirect_back_or(root_path)
  end
end
