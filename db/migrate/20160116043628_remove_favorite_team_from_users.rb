class RemoveFavoriteTeamFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :favorite_team, :string
  end
end
