class CreateFavoriteTeams < ActiveRecord::Migration
  def change
    create_table :favorite_teams do |t|
      t.string :name
      t.string :city
      t.references :user, index: true, foreign_key: true
      t.references :division, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
