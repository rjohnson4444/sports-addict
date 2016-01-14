require 'test_helper'

class GameStatisticsTest < ActiveSupport::TestCase
  test "game stats returns single game statistics for favorite team" do
    VCR.use_cassette("#game_stats") do
      make_favorite_teams
      favorite_team = "Denver Nuggets"

      binding.pry
      GameStatistics.game_stats(favorite_team)
    end
  end
end
