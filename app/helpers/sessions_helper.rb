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
    cookies[:_polls_remember_token] = {
      value: current_user.remember_token,
      expires: 2.weeks.from_now,
      httponly: true
    }
  end

  def sign_in_required
    unless signed_in?
      store_location
      redirect_to auth_path
    end
  end

  def no_signed_in_required
    if signed_in?
      redirect_to root_path
    end
  end

  def sign_out
    @current_user = nil
    session[:current_user_id] = nil
    session[:return_to] = nil
    forget_me
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
    if cookies[:_polls_remember_token].present?
      if user = GlobalID::Locator.locate_signed(cookies[:_polls_remember_token], for: 'sign_in')
        session[:current_user_id] = user.id
        user
      else
        forget_me
        nil
      end
    end
  end

  def forget_me
    cookies.delete :_polls_remember_token
  end

  def store_location(url = nil)
    if url
      session[:return_to] = url
    else
      session[:return_to] = request.url if request.get?
    end
  end
  def redirect_back_or(default)
    redirect_to(session.delete(:return_to) || default)
  end
end
