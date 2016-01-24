class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    user = current_user.update(favorite_team_id: params[:user][:favorite_team].to_i, description: params[:user][:description])
    flash[:success] = "Your favorite team has been set!"

    redirect_to dashboard_path
  end
end
