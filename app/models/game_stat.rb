class GameStat

  def self.service
    SportRadarService.new
  end

  def self.get_game_stats
    @get_game_stats ||= service.favorite_team_stats
  end

  def self.scores_by_quarter
    #use get_game_id to find the game for that day.
  end

  def self.game_alert_info(favorite_team)
    daily_games = get_game_stats
    favorite_team_game = daily_games[:games].select { |game| find_favorite_team_game(game, favorite_team) }
    get_game_id(favorite_team_game)
    get_daily_game_info(favorite_team_game, favorite_team)
  end

  private
    def self.get_daily_game_info(favorite_team_game, favorite_team)
      return build(if_no_game?(favorite_team)) if favorite_team_game.first.nil?

      opponent   = find_opponent(favorite_team_game, favorite_team)
      venue_name = favorite_team_game.first[:venue][:name]
      venue_address = favorite_team_game.first[:venue][:address]
      venue_city = favorite_team_game.first[:venue][:city]
      venue_state = favorite_team_game.first[:venue][:state]
      venue_zipcode = favorite_team_game.first[:venue][:zip]
      broadcast_name = favorite_team_game.first[:broadcast][:network]
      build( format_daily_game_info( opponent,
                             venue_name,
                             venue_address,
                             venue_city,
                             venue_state,
                             venue_zipcode
                             ) )
    end

    def self.format_daily_game_info(opponent, venue_name, venue_address, venue_city, venue_state, venue_zipcode)
      {
        opponent: opponent,
        venue_name: venue_name,
        venue_address: venue_address,
        venue_city: venue_city,
        venue_state: venue_state,
        venue_zipcode: venue_zipcode
      }
    end

    def self.if_no_game?(favorite_team)
      {
        message: "The #{favorite_team} do not play today!"
      }
    end

    def self.find_opponent(favorite_team_game, favorite_team)
      return build(if_no_game?(favorite_team)) if favorite_team_game.first.nil?

      if favorite_team_game.first[:home][:name].split(" ").last == favorite_team
        favorite_team_game.first[:away][:name]
      else
        favorite_team_game.first[:home][:name]
      end
    end

    def self.get_game_id(favorite_team_game)
      favorite_team_game.first[:id] unless favorite_team_game.first.nil?
    end

    def self.find_favorite_team_game(game, favorite_team)
      game[:home][:name].split(" ").last == favorite_team || game[:home][:name].split(" ").last == favorite_team
    end

    def self.build(data)
      OpenStruct.new(data)
    end
end
