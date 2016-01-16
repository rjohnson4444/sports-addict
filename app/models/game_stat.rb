class GameStat

  def self.service
    SportRadarService.new
  end

  def self.get_game_stats
    @get_game_stats ||= service.favorite_team_stats
  end

  def self.scores_by_quarter

  end

  def self.game_stats(favorite_team)
    daily_games = get_game_stats
    favorite_team_game = daily_games[:games].select { |game| find_favorite_team_game(game, favorite_team) }
    get_game_id(favorite_team_game)
    get_daily_game_info(favorite_team_game)
  end

  private
    def self.get_daily_game_info(favorite_team_game)

    end

    def self.get_game_id(favorite_team_game)
      favorite_team_game.first[:id]
    end

    def self.find_favorite_team_game(game, favorite_team)
      game[:home][:name].split(" ").last == favorite_team || game[:home][:name].split(" ").last == favorite_team
    end
end
