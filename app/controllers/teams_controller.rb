class TeamsController < ApplicationController
  def index
    @favorite_teams = FavoriteTeam.all
  end

  def show
  end
end
