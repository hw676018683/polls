module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      if verified_user = GlobalID::Locator.locate_signed(cookies[:_polls_remember_token], for: 'sign_in')
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end