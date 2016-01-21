module ApplicationHelper
  def cache_per_day
    prefix = "game-alert"
    day = Time.now.day
    [prefix, day].join("-")
  end

  def cache_for_profile(user)
    prefix      = user.name
    max_updated = User.maximum(:updated_at)

    [prefix, max_updated].join("-")
  end
end
