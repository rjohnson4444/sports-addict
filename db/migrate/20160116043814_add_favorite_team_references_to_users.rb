class AddFavoriteTeamReferencesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :favorite_team, index: true, foreign_key: true
  end
end
