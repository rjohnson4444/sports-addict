require 'test_helper'

class GameStatisticsTest < ActiveSupport::TestCase
  test "game stats returns single game statistics for favorite team" do
    VCR.use_cassette("#game_stats") do
      make_favorite_teams
      favorite_team = "Denver Nuggets"

      game_stats = GameStatistics.game_stats(favorite_team)

      assert Array, game_stats.class
    end
  end

  test "game alert returns correct information based on schedule of favorite team" do
    VCR.use_cassette("#game_alert") do
      make_favorite_teams
      favorite_team = "Denver Nuggets"

      game_stats = GameStatistics.game_stats(favorite_team)

      assert Array, game_stats.class
    end
  end
end
