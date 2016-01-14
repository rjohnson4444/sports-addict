class FavoriteTeam < ActiveRecord::Base
  belongs_to :user
  belongs_to :division


  def self.conference(favorite_team)
    team_name = find_team_name(favorite_team)
    conference_name = find_by(name: team_name).division.conference.name
    format_conference_name(conference_name)
  end

  private

    def self.find_team_name(favorite_team)
      favorite_team.split(" ").last
    end

    def self.format_conference_name(name)
      name.split(" ").map { |name| name.capitalize }.join(" ")
    end
end
