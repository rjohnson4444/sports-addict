module ApplicationHelper
  def cache_per_day
    prefix = "game-alert"
    day = Time.now.day
    [prefix, day].join("-")
  end

  def cache_for_profile(model_class, label = "")
    prefix      = model_class.to_s.downcase.pluralize
    max_updated = model_class.maximum(:updated_at)

    [prefix, max_updated].join("-")
  end
end
