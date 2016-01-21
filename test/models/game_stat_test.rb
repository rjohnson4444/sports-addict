require 'test_helper'

class GameStatTest < ActiveSupport::TestCase
  test "game_stats returns no stats message when no games for favorite team" do
    VCR.use_cassette("#game_stats") do
      make_favorite_teams

      favorite_team = "Nuggets"

      game_stats = GameStat.game_alert_info(favorite_team)

      assert_equal "The #{favorite_team} do not play today!", game_stats.message
    end
  end

  test "game_stats returns stats for favorite team game" do
    VCR.use_cassette("#game_stats_has_game") do
      make_favorite_teams

      favorite_team = "Thunder"

      game_stats = GameStat.game_alert_info(favorite_team)

      assert_equal "Charlotte Hornets", game_stats.opponent
      assert_equal "Chesapeake Energy Arena", game_stats.venue_name
      assert_equal "100 W. Reno Ave.", game_stats.venue_address
      assert_equal "Oklahoma City", game_stats.venue_city
      assert_equal "OK", game_stats.venue_state
      assert_equal "73102", game_stats.venue_zipcode
      assert_equal " 6 PM", game_stats.time_of_game
    end
  end

  test "scores_by_quarter returns no game message when no games" do
    VCR.use_cassette("#scores_by_quarter") do
      make_favorite_teams

      favorite_team = "Nuggets"

      scores_by_quarter = GameStat.all_game_stats(favorite_team)

      assert_equal "No game stats available.", scores_by_quarter.no_game_message
    end
  end

  test "scores_by_quarter returns game stats for the favorite team" do
    VCR.use_cassette("#scores_by_quarter_today_game") do
      make_favorite_teams

      favorite_team = "Thunder"

      scores_by_quarter = GameStat.all_game_stats(favorite_team)

      assert_equal "Oklahoma City", scores_by_quarter.home_team_name
      assert_equal "Charlotte", scores_by_quarter.away_team_name
      assert_equal 4, scores_by_quarter.home_team_stats_by_quarter.count
      assert_equal 4, scores_by_quarter.away_team_stats_by_quarter.count
      assert_equal 109, scores_by_quarter.home_team_total_points
      assert_equal 95, scores_by_quarter.away_team_total_points
      assert_equal "Kevin Durant", scores_by_quarter.home_team_stats_leaders
                                                      .points_leader_name
      assert_equal 26, scores_by_quarter.home_team_stats_leaders.points
      assert_equal "Kemba Walker", scores_by_quarter.away_team_stats_leaders
                                                      .points_leader_name
      assert_equal 21, scores_by_quarter.away_team_stats_leaders.points
      assert_equal "Steven Adams", scores_by_quarter.home_team_stats_leaders
                                                      .rebounds_leader_name
      assert_equal 10, scores_by_quarter.home_team_stats_leaders.rebounds
      assert_equal "Spencer Hawes", scores_by_quarter.away_team_stats_leaders
                                                      .rebounds_leader_name
      assert_equal 6, scores_by_quarter.away_team_stats_leaders.rebounds
      assert_equal "Russell Westbrook", scores_by_quarter.home_team_stats_leaders
                                                      .assists_leader_name
      assert_equal 15, scores_by_quarter.home_team_stats_leaders.assists
      assert_equal "Frank Kaminsky", scores_by_quarter.away_team_stats_leaders
                                                      .assists_leader_name
      assert_equal 4, scores_by_quarter.away_team_stats_leaders.assists
    end
  end
end
