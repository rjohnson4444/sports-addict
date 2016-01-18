class GameStat

  def self.all_game_stats(favorite_team)
    favorite_team_game_today = daily_games(favorite_team)
    today_game_id            = get_game_id(favorite_team_game_today)
    game_stats               = get_quarter_by_quarter_stats(today_game_id)

    build(all_scores_by_quarters(game_stats))
  end

  def self.game_alert_info(favorite_team)
    favorite_team_game = daily_games(favorite_team)

    get_daily_game_info(favorite_team_game, favorite_team)
  end

  private

    def self.service
      SportRadarService.new
    end

    def self.build(data)
      OpenStruct.new(data)
    end

    def self.get_quarter_by_quarter_stats(game_id)
      @get_quarter_by_quarter_stats ||= service.game_summary(game_id) unless game_id.nil?
    end

    def self.all_todays_game_info
      @all_todays_game_info ||= service.nba_scheduled_games_for_today
    end

    def self.all_scores_by_quarters(game_stats)
      if game_stats.nil?
        no_game_today_message
      else
        home_team_name             = game_stats[:home][:market]
        home_team_stats_by_quarter = format_stats_by_quarter(game_stats[:home][:scoring])
        home_team_total_points     = game_stats[:home][:points]
        away_team_name             = game_stats[:away][:market]
        away_team_stats_by_quarter = format_stats_by_quarter(game_stats[:away][:scoring])
        away_team_total_points     = game_stats[:away][:points]
        home_team_stats_leaders    = format_stat_leaders(game_stats[:home][:market], game_stats[:home][:leaders])
        away_team_stats_leaders    = format_stat_leaders(game_stats[:away][:market], game_stats[:away][:leaders])

        format_all_scores_by_quarter(home_team_name,
                                     home_team_stats_by_quarter,
                                     home_team_total_points,
                                     away_team_name,
                                     away_team_stats_by_quarter,
                                     away_team_total_points,
                                     home_team_stats_leaders,
                                     away_team_stats_leaders
                                     )
      end
    end

    def self.format_all_scores_by_quarter(home_team_name, home_team_stats, home_team_total, away_team_name, away_team_stats, away_team_total, home_leaders, away_leaders)
      {
        home_team_name:             home_team_name,
        home_team_stats_by_quarter: home_team_stats,
        home_team_total_points:     home_team_total,
        away_team_name:             away_team_name,
        away_team_stats_by_quarter: away_team_stats,
        away_team_total_points:     away_team_total,
        home_team_stats_leaders:    build(home_leaders),
        away_team_stats_leaders:    build(away_leaders)
      }
    end

    def self.format_stat_leaders(name, game_stats)
      {
        team_name: name,
        points_leader_name:   game_stats[:points].first[:full_name],
        points:               game_stats[:points].first[:statistics][:points],
        rebounds_leader_name: game_stats[:rebounds].first[:full_name],
        rebounds:             game_stats[:rebounds].first[:statistics][:rebounds],
        assists_leader_name:  game_stats[:assists].first[:full_name],
        assists:              game_stats[:assists].first[:statistics][:assists]
      }
    end

    def self.format_stats_by_quarter(stats)
      stats.map { |quarter| build(quarter) }
    end

    def self.no_game_today_message
      {
        no_game_message: "No game stats available."
      }
    end

    def self.daily_games(favorite_team)
      all_todays_game_info[:games].select { |game| find_favorite_team_game(game, favorite_team) }
    end

    def self.get_daily_game_info(favorite_team_game, favorite_team)
      return build(if_no_game?(favorite_team)) if favorite_team_game.first.nil?

      opponent       = find_opponent(favorite_team_game, favorite_team)
      venue_name     = favorite_team_game.first[:venue][:name]
      venue_address  = favorite_team_game.first[:venue][:address]
      venue_city     = favorite_team_game.first[:venue][:city]
      venue_state    = favorite_team_game.first[:venue][:state]
      venue_zipcode  = favorite_team_game.first[:venue][:zip]
      broadcast_name = favorite_team_game.first[:broadcast][:network]

      build( format_daily_game_info( opponent,
                             venue_name,
                             venue_address,
                             venue_city,
                             venue_state,
                             venue_zipcode,
                             broadcast_name
                             ) )
    end

    def self.format_daily_game_info(opponent, venue_name, venue_address, venue_city, venue_state, venue_zipcode, broadcast_name)
      {
        opponent:      opponent,
        venue_name:    venue_name,
        venue_address: venue_address,
        venue_city:    venue_city,
        venue_state:   venue_state,
        venue_zipcode: venue_zipcode,
        broadcast:     broadcast_name
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
      return game[:home][:name]
              .split(" ")
              .last(2)
              .join(" ") == favorite_team ||
             game[:away][:name]
              .split(" ")
              .last(2)
              .join(" ") if favorite_team == "Trail Blazers"

      game[:home][:name]
        .split(" ")
        .last == favorite_team ||
      game[:away][:name]
        .split(" ")
        .last == favorite_team
    end
end
