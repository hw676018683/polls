ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  include SessionsHelper
end

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:skylark] = OmniAuth::AuthHash.new({
  provider: :skylark,
  uid: 1,
  info: FactoryGirl.attributes_for(:user),
  credentials: {
    token: "5918413e02ff8450af8a84694e52635a7c6cb9c7cec699b3b6db3643b34d939d",
    expires_at: 1.hour.from_now.to_i,
    expires: true
  },
  extra: {}
})
