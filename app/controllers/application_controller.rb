class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  include ApplicationHelper
  include SessionsHelper

  before_action :random_user

  private

  def render_json_error(obj = nil)
    if obj.respond_to? :errors
      render json: obj.errors, status: :unprocessable_entity
    else
      render json: MultiJson.dump(base: ['参数错误']), status: :unprocessable_entity
    end
  end

  def random_user
    # sign_in User.first
    n = params[:n] || 1
    sign_in User.find(n)
  end
end
