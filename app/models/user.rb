class User < ActiveRecord::Base

  def self.from_twitter_omniauth(oauth_info)
    user = where(uid: oauth_info.uid).first_or_create
    user.update(
      name: oauth_info.info.name,
      profile_image: oauth_info.info.image,
      favorite_team: "Oklahoma City Thunder",
      oauth_token: oauth_info.credentials.token,
      oauth_secret: oauth_info.credentials.secret
    )
    user
  end

end
