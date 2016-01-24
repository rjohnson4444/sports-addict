module ApplicationHelper
  def cache_for_profile(user)
    prefix      = user.name
    max_updated = User.maximum(:updated_at)

    [prefix, max_updated].join("-")
  end
end
