class HomeController < ApplicationController
  def index
  end

  def show
    @user = current_user
    @standings = Standing.standings(favorite_team)
  end

  private

    def favorite_team
      current_user.favorite_team
    end
end
