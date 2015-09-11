require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Skylark < OmniAuth::Strategies::OAuth2
      option :name, :skylark

      option :client_options, {
        # site: 'http://skylarkly.com',
        site: 'http://127.0.0.1:3000',
        authorize_url: '/oauth/authorize'
      }

      uid { raw_info['id'] }

      info do
        {
          name: raw_info['name'],
          nickname: raw_info['nickname'],
          phone: raw_info['phone'],
          qq: raw_info['qq'],
          headimgurl: raw_info['headimgurl'],
          organization_ids: raw_info['organization_ids']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/user.json').parsed
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :skylark,
    '48288946910e8996aa1499cabf4b7eee4169fb9a7f27bde16863233cd8a84387',
    '5463337b45d642d722b4e499210594500f0e4989eae3426292cc571282ca0778'
end

