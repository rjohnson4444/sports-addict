class FavoriteTeam < ActiveRecord::Base
  has_many :users
  belongs_to :division

  def self.division(favorite_team)
    division_name = find_by(name: favorite_team).division.name
    format_division_name(division_name)
  end

  def self.favorite_team_info(favorite_team)
    find_by(name: favorite_team)
  end

  def format_name_for_modal
    "#{self.city} #{self.name}"
  end

  private

    def self.find_team_name(favorite_team)
      favorite_team.split(" ").last
    end

    def self.format_division_name(name)
      name.split(" ").map { |name| name.capitalize }.join(" ")
    end
end
