class HomeController < ApplicationController
  def index
  end

  def show
    @user                     = current_user
    @standings                = Standing.standings(favorite_team)
    @favorite_team_division   = FavoriteTeam.division(favorite_team)
    @team_info                = FavoriteTeam.favorite_team_info(favorite_team)
    sleep(0.5)
    @game_alert_info          = GameStat.game_alert_info(favorite_team)
    sleep(0.5)
    @all_game_stats            = GameStat.all_game_stats(favorite_team)
  end

  private

    def favorite_team
      current_user.favorite_team.name
    end
end
