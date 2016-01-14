require 'test_helper'

class StandingTest < ActionDispatch::IntegrationTest
  test "#standings" do
    VCR.use_cassette("#standing") do
      make_favorite_teams
      favorite_team = "Denver Nuggets"

      standings = Standing.standings(favorite_team).first

      assert_equal "Oklahoma City", standings.city
      assert_equal "Thunder",       standings.name
      assert_equal "28-12",         standings.record
    end
  end

  test "formating conference name" do
    conference_name = "EASTERN CONFERENCE"

    formatted_conference_name = Standing.format_conference_name(conference_name)

    assert_equal "Eastern Conference", formatted_conference_name
  end
end
