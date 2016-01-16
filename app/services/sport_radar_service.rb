class SportRadarService
  attr_accessor :connection

  def initialize
    @connection = Hurley::Client.new("http://api.sportradar.us/nba-t3/")
  end

  def favorite_team_standings
    parse_json(connection.get("seasontd/2015/REG/standings.json" + api_key))
  end

  def favorite_team_stats
    date = Time.now
    parse_json(connection.get("games/#{date.year}/#{date.month}/15/schedule.json" + api_key))
  end

  private
    def parse_json(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def api_key
      "?api_key=#{ENV["SPORTS_API_KEY"]}"
    end
end
