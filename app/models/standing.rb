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
    team_standings = parse_standings_response(all_standings, favorite_team)
    team_standings.map { |team| build(team) }
  end

  private

    def self.build(data)
      OpenStruct.new(data)
    end

    def self.parse_standings_response(all_standings, favorite_team)
      favorite_team_conference = find_conference(favorite_team)
      favorite_team_division = find_division(favorite_team)

      all_standings[:conferences]
            .select { |conference| conference[:name] == favorite_team_conference }
            .first[:divisions]
            .select { |division| division[:name] == favorite_team_division }
            .first[:teams]
            .map { |team|  format_standings(team) }

    end

    def self.find_conference(favorite_team)
      name = format_team_name(favorite_team)
      FavoriteTeam.find_by(name: name).division.conference.name
    end

    def self.find_division(favorite_team)
      name = format_team_name(favorite_team)
      FavoriteTeam.find_by(name: name).division.name
    end

    def self.format_team_name(favorite_team)
      favorite_team.split(" ").last
    end

    def self.format_conference_name(name)
      name.split(" ").map { |name| name.capitalize }.join(" ")
    end

    def self.format_standings(team)
      image = FavoriteTeam.find_by(name: team[:name]).image
      { city: team[:market], name: team[:name], record:  "#{team[:wins]}-#{team[:losses]}", image: image }
    end
end
