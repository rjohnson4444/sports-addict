class User < ActiveRecord::Base
  belongs_to :favorite_team
  has_many :posts
  has_many :follows

  def followed_by(user = nil)
    user.follows.find_by(target_id: id)
  end

  def self.from_twitter_omniauth(oauth_info)
    user = where(uid: oauth_info.uid).first_or_create
    user.update(
      name: oauth_info.info.name,
      profile_image: oauth_info.info.image,
      oauth_token: oauth_info.credentials.token,
      oauth_secret: oauth_info.credentials.secret,
    )
    user
  end
end
