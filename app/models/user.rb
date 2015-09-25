class User < ActiveRecord::Base
  validates :uid, presence: true
  validates :name, presence: true

  has_many :polls, dependent: :destroy

  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash[:uid])
      user.name = auth_hash[:info][:name]
      user.nickname = auth_hash[:info][:nickname]
      user.phone = auth_hash[:info][:phone]
      user.headimgurl = auth_hash[:info][:headimgurl]
      user.save
      user
    end
  end

  def remember_token
    to_sgid(expires_in: 2.weeks, for: 'sign_in')
  end
end
