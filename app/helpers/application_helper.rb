module ApplicationHelper
  def auth_path
    "http://cunchuhulian.skylarkly.com/oauth/authorize?client_id=6f7f661aa6b9b53f86b5caca6e4ee49e6763cff7440ce0df2f85631eb1e7fdc7&redirect_uri=http://#{request.host_with_port}/auth/cunchu/callback&response_type=code"
  end
end
