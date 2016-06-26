class HomeController < ApplicationController
  before_action :create_enricher

  def index
  end

  def show
    @user = current_user

    if @user.favorite_team.nil?
      @pick_favorite_team = true
      @favorite_team      = FavoriteTeam.all
    else
      @standings              = Standing.standings(favorite_team)
      @favorite_team_division = FavoriteTeam.division(favorite_team)
      @team_info              = FavoriteTeam.favorite_team_info(favorite_team)
      @game_alert_info        = GameStat.game_alert_info(favorite_team)
      @all_game_stats         = GameStat.all_game_stats(favorite_team)
      @today_game_schedule    = GameStat.scheduled_games_today
      @activities             = stream_feed(current_user.id)
    end
  end


  private

    def favorite_team
      current_user.favorite_team.name
    end

    def stream_feed(current_user_id)
      feed         ||= StreamRails.feed_manager.get_news_feeds(current_user_id)[:flat]
      results      = feed.get(limit: 10)['results']
      @activities  = @enricher.enrich_activities(results)
    end

    def create_enricher
      @enricher = StreamRails::Enrich.new
    end
end
