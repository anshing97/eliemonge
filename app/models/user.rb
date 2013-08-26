class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  def self.create_with_omniauth(auth)

    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["username"]
      user.token = auth["credentials"].token
      user.secret = auth["credentials"].secret
    end
  end

  def update_credentials (auth)
    self.token = auth["credentials"].token
    self.secret = auth["credentials"].secret
    self.save
  end

end
