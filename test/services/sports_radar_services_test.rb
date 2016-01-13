require 'test_helper'

class SportRadarServiceTest < ActiveSupport::TestCase

  test "#users" do
    VCR.use_cassette("sport_radar_service#user") do
      favorite_team = "Denver Nuggets"
      standings = Standing.standings(favorite_team).first

      assert_equal "Cleveland", standings.city
      assert_equal "Cavaliers", standings.name
      assert_equal "27-9",      standings.record
    end
  end
end
