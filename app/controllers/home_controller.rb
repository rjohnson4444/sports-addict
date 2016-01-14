class HomeController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @standings = Standing.standings(favorite_team)
    @favorite_team_conference = FavoriteTeam.conference(favorite_team)
    @today_game_stats = GameStatistics.game_stats(favorite_team)
    @game_alert = GameStatistics.game_alert(favorite_team)
  end

  private

    def favorite_team
      current_user.favorite_team
    end
end
