require 'test_helper'

class StandingTest < ActiveSupport::TestCase
  test "#standings" do
    VCR.use_cassette("#standing") do
      make_favorite_teams
      favorite_team = "Nuggets"

      standings = Standing.standings(favorite_team).first

      assert_equal "Oklahoma City", standings.city
      assert_equal "Thunder",       standings.name
      assert_equal "29-12",         standings.record
    end
  end
end
