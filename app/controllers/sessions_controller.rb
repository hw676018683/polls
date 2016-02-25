class SessionsController < ApplicationController
  before_action :no_signed_in_required, only: [:create]

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in user

    redirect_back_or(root_path)
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
