class Standing

  def self.service
    SportRadarService.new
  end

  # def self.standings(favorite_team)
  #   all_standing = service.favorite_team_standings(favorite_team)
  #   team_standings =  all_standing[:conferences]
  #                       .select { |conference| conference[:name] == "EASTERN CONFERENCE" }
  #                       .first[:divisions]
  #                       .select { |division| division[:name] == "Central" }
  #                       .first[:teams]
  #                       .select { |team| team[:market] == "Cleveland" }
  #                       .first
  #   build(team_standings)
  # end

  def self.standings(favorite_team)
    all_standings = service.favorite_team_standings
    team_standings = parse_standings_response(all_standings)
    team_standings.map { |team| build(team) }
  end

  private

    def self.build(data)
      OpenStruct.new(data)
    end

    def self.parse_standings_response(all_standings)
      all_standings[:conferences]
            .select { |conference| conference[:name] == "EASTERN CONFERENCE" }
            .first[:divisions]
            .select { |division| division[:name] == "Central" }
            .first[:teams]
            .map { |team|  format_standings(team) }

    end

    def self.format_standings(team)
      { city: team[:market], name: team[:name], record:  "#{team[:wins]}-#{team[:losses]}" }
    end
end
