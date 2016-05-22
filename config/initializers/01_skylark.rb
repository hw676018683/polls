module OmniAuth
  module Strategies
    class Cunchu < OmniAuth::Strategies::OAuth2
      option :name, :cunchu

      option :client_options, {
        :site => "http://cunchuhulian.skylarkly.com",
        :authorize_url => "/oauth/authorize"
      }

      uid { raw_info["id"] }

      info do
        {
          :name => raw_info["name"],
          :nickname => raw_info["nickname"],
          :phone => raw_info["phone"],
          :qq => raw_info["qq"],
          :headimgurl => raw_info["headimgurl"],
          :organization_ids => raw_info["root_organization_ids"],
          :namespace_id => raw_info["namespace_id"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/user.json').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cunchu,
    '6f7f661aa6b9b53f86b5caca6e4ee49e6763cff7440ce0df2f85631eb1e7fdc7',
    'ac8ac12df5bbdc1120d9b8fbf27bd456414a22d5c7abd6858dfffb522303c12b',
    provider_ignores_state: true
end
