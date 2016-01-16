class RemoveUserReferencesFromFavoriteTeams < ActiveRecord::Migration
  def change
    remove_reference :favorite_teams, :user, index: true, foreign_key: true
  end
end
