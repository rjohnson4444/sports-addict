# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class Seed
  def self.start
    seed = Seed.new
    seed.generate_conferences
    seed.generate_divisions
    seed.generate_atlantic_division
    seed.generate_central_division
    seed.generate_southeast_division
    seed.generate_southwest_division
    seed.generate_northwest_division
    seed.generate_pacific_division
  end

  def generate_conferences
    conferences = ["EASTERN CONFERENCE", "WESTERN CONFERENCE"]

    conferences.each do |name|
      Conference.create!( name: name )
      puts "#{name} created!"
    end
  end

  def generate_divisions
    divisions_eastern = %w(Atlantic Central Southeast)
    divisions_western = %w(Southwest Northwest Pacific)

    relate_conference_to_division(divisions_eastern, 1)
    relate_conference_to_division(divisions_western, 2)
  end

  def relate_conference_to_division(divisions, conference_id)
    divisions.each do |division|
      Division.create!( name: division, conference_id: conference_id )
      puts "#{division} created!"
    end
  end

  def generate_atlantic_division
    teams = [
      ["Boston", "Celtics"],
      ["Brooklyn", "Nets"],
      ["New York", "Knicks"],
      ["Philadelphia", "76ers"],
      ["Toronto", "Raptors"]
    ]

    make_division_with_teams(teams, 1)
  end

  def generate_central_division
    teams = [
      ["Chicago", "Bulls"],
      ["Cleveland", "Cavaliers"],
      ["Detroit", "Pistons"],
      ["Indiana", "Pacers"],
      ["Milwaukee", "Bucks"]
    ]

    make_division_with_teams(teams, 2)
  end

  def generate_southeast_division
    teams = [
      ["Atlanta", "Hawks"],
      ["Charlotte", "Hornets"],
      ["Miami", "Heat"],
      ["Orlando", "Magic"],
      ["Washington", "Wizards"]
    ]

    make_division_with_teams(teams, 3)
  end

  def generate_southwest_division
    teams = [
      ["Dallas", "Mavericks"],
      ["Houston", "Rockets"],
      ["Memphis", "Grizzlies"],
      ["New Orleans", "Pelicans"],
      ["San Antonio", "Spurs"]
    ]

    make_division_with_teams(teams, 4)
  end

  def generate_northwest_division
    teams = [
      ["Denver", "Nuggets"],
      ["Minnesota", "Timberwolves"],
      ["Portland", "Trail Blazers"],
      ["Oklahoma City", "Thunder"],
      ["Utah", "Jazz"]
    ]

    make_division_with_teams(teams, 5)
  end

  def generate_pacific_division
    teams = [
      ["Golden State", "Warriors"],
      ["Los Angeles", "Clippers"],
      ["Los Angeles", "Lakers"],
      ["Phoenix", "Suns"],
      ["Sacramento", "Kings"]
    ]

    make_division_with_teams(teams, 6)
  end

  def add_image(name)
    file_name = name.split(" ").last.downcase
    "#{file_name}.gif"
  end

  def make_division_with_teams(teams, division_id)
    teams.each do |team|
      favorite_team = FavoriteTeam.create!(city: team[0], name: team[1], division_id: division_id)
      favorite_team.update(image: add_image(team[1]))
      puts "#{team} created!"
    end
  end
end

Seed.start
