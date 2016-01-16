require 'test_helper'

class SportRadarServiceTest < ActiveSupport::TestCase
  test "#standings" do
    VCR.use_cassette("#standing") do
      make_favorite_teams
      favorite_team = "Denver Nuggets"

      standings = Standing.standings(favorite_team).first

      assert_equal "Oklahoma City", standings.city
      assert_equal "Thunder",       standings.name
      assert_equal "29-12",         standings.record
    end
  end

  test "game_stats returns stats for favorite teams daily game" do
    VCR.use_cassette("#game_stats") do
      make_favorite_teams

      favorite_team = "Nuggets"

      game_stats = GameStat.game_stats(favorite_team)
    end
  end

  test "formating conference name" do
    conference_name = "EASTERN CONFERENCE"

    formatted_conference_name = Standing.format_conference_name(conference_name)

    assert_equal "Eastern Conference", formatted_conference_name
  end
end
