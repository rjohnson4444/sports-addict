class GameStatistics

  def self.service
    @service = SportRadarService.new
  end

  def self.game_stats(favorite_team)
    raw_stats = service.favorite_team_game_stats
    game = today_game(raw_stats, favorite_team).first
  end

  private
    def self.build(data)
      OpenStruct.new(data)
    end

    def self.today_game(raw_stats, favorite_team)
      raw_stats[:games]
        .select { |game| game[:home][:name] == favorite_team || game[:away][:name] == favorite_team }
    end
end
