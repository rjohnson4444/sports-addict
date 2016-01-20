class HomeController < ApplicationController
  before_action :create_enricher

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
    @all_game_stats           = GameStat.all_game_stats(favorite_team)

    feed                      = StreamRails.feed_manager.get_news_feeds(current_user.id)[:flat]
    results                   = feed.get['results']
    @activities               = @enricher.enrich_activities(results)
    binding.pry
  end

  private

    def favorite_team
      current_user.favorite_team.name
    end

    def create_enricher
      @enricher = StreamRails::Enrich.new
    end
end
