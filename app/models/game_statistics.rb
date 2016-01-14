class GameStatistics

  def self.service
    @service = SportRadarService.new
  end

  def self.game_stats(favorite_team)
    raw_stats = service.favorite_team_game_stats
    today_game_stats(raw_stats, favorite_team)
    binding.pry
  end

  def self.game_alert(game, favorite_team)
    if game_stats.empty?
      "The #{favorite_team} do not play today. Damn!"
    else
      build(game_alert_info(game))
    end
  end

  def game_alert_info(game_info)
    game_info
  end

  private
    def self.build(data)
      OpenStruct.new(data)
    end

    def self.today_game_stats(raw_stats, favorite_team)
      raw_stats[:games]
        .select { |game| game[:home][:name] == favorite_team || game[:away][:name] == favorite_team }
    end
end
