class SportRadarService
  attr_accessor :connection

  def initialize
    @connection = Hurley::Client.new("http://api.sportradar.us/nba-t3/")
  end

  def favorite_team_standings
    parse_json(connection.get("seasontd/2015/REG/standings.json" + api_key))
  end

  def nba_scheduled_games_for_today
    # use 1/14/2016 for testing
    date = Time.now
    parse_json(connection.get("games/#{date.year}/#{date.month}/#{date.day}/schedule.json" + api_key))
  end

  def game_summary(game_id)
    parse_json(connection.get("games/#{game_id}/boxscore.json" + api_key))
  end

  private
    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def api_key
      "?api_key=#{ENV["SPORTS_API_KEY"]}"
    end
end
