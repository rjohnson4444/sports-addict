class User < ActiveRecord::Base
  belongs_to :favorite_team

  def self.from_twitter_omniauth(oauth_info)
    user = where(uid: oauth_info.uid).first_or_create
    user.update(
      name: oauth_info.info.name,
      profile_image: oauth_info.info.image,
      oauth_token: oauth_info.credentials.token,
      oauth_secret: oauth_info.credentials.secret,
      favorite_team_id: 21
    )
    user
  end

end
