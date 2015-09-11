module SessionsHelper
  def current_user
    @current_user ||= sign_in_from_session || sign_in_from_cookies
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_in user
    @current_user = user
    session[:current_user_id] = user.id
    remember_me
  end

  def remember_me
    cookies.permanent[:remember_token] = {
      value: current_user.remember_token,
      httponly: true
    }
  end

  private
  def sign_in_from_session
    if session[:current_user_id].present?
      begin
        User.find session[:current_user_id]
      rescue
        session[:current_user_id] = nil
      end
    end
  end

  def sign_in_from_cookies
    if cookies[:remember_token].present?
      if user = GlobalID::Locator.locate_signed(cookies[:remember_token], for: 'sign_in')
        session[:current_user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end
end
