require 'test_helper'

class FavoriteTeamTest < ActiveSupport::TestCase
  test "formating division name by favorite team" do
    make_favorite_teams
    favorite_team = "Nuggets"

    division_name = FavoriteTeam.division(favorite_team)
    assert_equal "Northwest", division_name
  end
end
