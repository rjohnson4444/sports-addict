class AddImageUrlToFavoriteTeams < ActiveRecord::Migration
  def change
    add_column :favorite_teams, :image, :string
  end
end
